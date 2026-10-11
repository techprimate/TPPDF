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
