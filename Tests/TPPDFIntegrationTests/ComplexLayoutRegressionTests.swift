//
//  ComplexLayoutRegressionTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct ComplexLayoutRegressionTests {
    @Test func imageDelegateReceivesFinalFrameAndCanReplacePixelsBeforeDrawing() throws {
        // Arrange
        let document = TPPDF.PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 200, height: 180), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (0, 0)
        ))
        let image = try CommonDocumentFixture.image(size: CGSize(width: 30, height: 30))
        let replacement = try CommonDocumentFixture.image(size: CGSize(width: 30, height: 30),
                                                           color: CGColor(red: 1, green: 0, blue: 0, alpha: 1))
        document.add(image: image)
        let delegate = ReplacingImageDelegate(replacement: replacement.image)
        let generator = PDFGenerator(document: document)
        generator.delegate = delegate

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)
        let page = try #require(output.page(at: 0))
        let context = try #require(CGContext(data: nil, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4,
                                            space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue))
        context.translateBy(x: -35, y: -145)
        page.draw(with: .mediaBox, to: context)
        let pixels = try #require(context.data).assumingMemoryBound(to: UInt8.self)

        // Assert
        #expect(output.pageCount == 1)
        try #require(delegate.images.count == 1)
        #expect(delegate.images[0] === image)
        #expect(delegate.frames == [CGRect(x: 20, y: 20, width: 30, height: 30)])
        // Color conversion can change channel values, but the replacement must be red rather than the original blue.
        #expect(Int(pixels[0]) > Int(pixels[1]) + 128)
        #expect(Int(pixels[0]) > Int(pixels[2]) + 128)
    }

    @Test(arguments: [CGFloat(0), 25], [false, true])
    func breakingGroupKeepsContinuationPaddingAndDoesNotCoverPageHeaders(topPadding: CGFloat, debug: Bool) throws {
        // Arrange
        let document = TPPDF.PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 200, height: 240), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (5, 5)
        ))
        document.set(font: Font.systemFont(ofSize: 12))
        document.set(.headerLeft, font: Font.systemFont(ofSize: 12))
        document.set(.footerLeft, font: Font.systemFont(ofSize: 10))
        document.add(.headerLeft, text: "HEADER")
        document.add(.footerLeft, text: "FOOTER")
        document.add(text: "BEFORE")
        let markers = (0..<40).map { "GROUPLINE\($0)END" }
        let group = PDFGroup(allowsBreaks: true, backgroundColor: Color(white: 0.95, alpha: 1),
                             padding: EdgeInsets(top: topPadding, left: 8, bottom: 10, right: 8))
        group.add(text: markers.joined(separator: "\n"))
        document.add(group: group)
        document.add(text: "AFTER")
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(output.pageCount > 2)
        #expect(generator.totalPages == output.pageCount)
        let allText = try #require(output.string)
        for marker in ["BEFORE"] + markers + ["AFTER"] {
            #expect(allText.components(separatedBy: marker).count - 1 == 1)
        }
        for index in 0..<output.pageCount {
            let page = try #require(output.page(at: index))
            let text = try #require(page.string)
            #expect(text.components(separatedBy: "HEADER").count - 1 == 1)
            #expect(text.components(separatedBy: "FOOTER").count - 1 == 1)
            let header = try #require(page.selection(for: (text as NSString).range(of: "HEADER")))
            let marker = try #require(markers.first { text.contains($0) })
            let firstLine = try #require(page.selection(for: (text as NSString).range(of: marker)))
            #expect(header.bounds(for: page).minY - firstLine.bounds(for: page).maxY >= topPadding)
            #expect(try blackPixels(on: page, in: header.bounds(for: page)) > 5, "Header must remain visible on page \(index)")
        }
        #expect(generator.currentPadding == .zero)
    }

    private func blackPixels(on page: PDFPage, in bounds: CGRect) throws -> Int {
        let crop = bounds.integral
        let context = try #require(CGContext(
            data: nil, width: Int(crop.width), height: Int(crop.height), bitsPerComponent: 8, bytesPerRow: Int(crop.width) * 4,
            space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ))
        context.setFillColor(gray: 1, alpha: 1)
        context.fill(CGRect(origin: .zero, size: crop.size))
        context.translateBy(x: -crop.minX, y: -crop.minY)
        page.draw(with: .mediaBox, to: context)
        let bytes = try #require(context.data).assumingMemoryBound(to: UInt8.self)
        return stride(from: 0, to: context.bytesPerRow * context.height, by: 4).filter {
            Int(bytes[$0]) + Int(bytes[$0 + 1]) + Int(bytes[$0 + 2]) < 150
        }.count
    }

    private final class ReplacingImageDelegate: PDFGeneratorImageDelegate {
        let replacement: Image
        var images: [PDFImage] = []
        var frames: [CGRect] = []

        init(replacement: Image) {
            self.replacement = replacement
        }

        func generator(willBeginDrawingImage image: PDFImage, with _: PDFContext, in frame: CGRect) {
            images.append(image)
            frames.append(frame)
            image.image = replacement
        }
    }

    @Test(arguments: [false, true], [false, true])
    func unbreakableGroupDoesNotIndentFollowingContentWhenMoved(moveToNextPage: Bool, debug: Bool) throws {
        // Arrange
        let document = TPPDF.PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 200, height: 240), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (0, 0)
        ))
        document.add(text: "BEFORE")
        if moveToNextPage { document.add(space: 150) }
        let group = PDFGroup(allowsBreaks: false, backgroundColor: Color(white: 0.95, alpha: 1),
                             padding: EdgeInsets(top: 10, left: 24, bottom: 10, right: 32))
        group.add(text: "GROUP")
        document.add(group: group)
        document.add(text: "AFTER")
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(output.pageCount == (moveToNextPage ? 2 : 1))
        #expect(generator.totalPages == output.pageCount)
        let page = try #require(output.page(at: output.pageCount - 1))
        let text = try #require(page.string)
        let groupRange = (text as NSString).range(of: "GROUP")
        let afterRange = (text as NSString).range(of: "AFTER")
        try #require(groupRange.location != NSNotFound)
        try #require(afterRange.location != NSNotFound)
        let groupSelection = try #require(page.selection(for: groupRange))
        let afterSelection = try #require(page.selection(for: afterRange))
        #expect(abs(afterSelection.bounds(for: page).minX - 20) < 0.01)
        #expect(afterSelection.bounds(for: page).maxY <= groupSelection.bounds(for: page).minY)
        #expect(generator.currentPadding == .zero)
    }
}
#endif
