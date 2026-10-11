//
//  CommonDocumentTests.swift
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

struct CommonDocumentTests {
    @Test(arguments: CommonDocumentFixture.Kind.allCases, [
        (paper: CommonDocumentFixture.Paper.a4, debug: false), (.a4, true),
        (.letter, false), (.letter, true), (.landscape, false), (.landscape, true),
    ])
    func officeDocumentsPreserveContentOrderPageFurnitureAndVisibleText(
        kind: CommonDocumentFixture.Kind, scenario: (paper: CommonDocumentFixture.Paper, debug: Bool)
    ) throws {
        // Arrange
        let fixture = try CommonDocumentFixture.make(kind, paper: scenario.paper)
        let generator = PDFGenerator(document: fixture.document)
        generator.debug = scenario.debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(generator.totalPages == output.pageCount)
        try assertDocument(output, matches: fixture)
    }

    @Test(arguments: CommonDocumentFixture.Kind.allCases)
    func freshOfficeDocumentGeneratorsProduceStableLayoutAndContent(kind: CommonDocumentFixture.Kind) throws {
        // Arrange
        let fixture = try CommonDocumentFixture.make(kind, paper: .a4)
        let independentFixture = try CommonDocumentFixture.make(kind, paper: .a4)
        let firstGenerator = PDFGenerator(document: fixture.document)
        let secondGenerator = PDFGenerator(document: independentFixture.document)

        // Act
        let firstData = try firstGenerator.generateData()
        let secondData = try secondGenerator.generateData()
        let firstDocument = PDFKit.PDFDocument(data: firstData)
        let secondDocument = PDFKit.PDFDocument(data: secondData)
        let first = try #require(firstDocument)
        let second = try #require(secondDocument)

        // Assert
        #expect(second.pageCount == first.pageCount)
        #expect(second.string == first.string)
        #expect(secondGenerator.totalPages == second.pageCount)
        try assertDocument(second, matches: fixture)
    }

    @Test(arguments: [false, true])
    func officeDocumentPacketPreservesMemberOrderAndExplicitMetadata(writeFile: Bool) throws {
        // Arrange
        let letter = try CommonDocumentFixture.make(.letter, paper: .a4)
        let invoice = try CommonDocumentFixture.make(.invoice, paper: .letter)
        let generator = PDFMultiDocumentGenerator(documents: [letter.document, invoice.document])
        let info = PDFInfo(title: "Client packet", author: "Packet Team", subject: "Handover and invoice")
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".pdf")
        defer { if writeFile { try? FileManager.default.removeItem(at: url) } }

        // Act
        let data: Data
        if writeFile {
            try generator.generate(to: url, info: info)
            data = try Data(contentsOf: url)
        } else {
            data = try generator.generateData(info: info)
        }
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        let text = try #require(output.string)
        let endOfLetter = (text as NSString).range(of: "SIGNATURE")
        let startOfInvoice = (text as NSString).range(of: "INVOICETITLE")
        #expect(endOfLetter.location != NSNotFound)
        #expect(startOfInvoice.location > endOfLetter.location)
        for (marker, count) in letter.markerCounts.merging(invoice.markerCounts, uniquingKeysWith: +) {
            #expect(text.components(separatedBy: marker).count - 1 == count, "Packet marker \(marker)")
        }
        let metadata = try #require(output.documentAttributes)
        #expect(metadata[PDFDocumentAttribute.titleAttribute] as? String == "Client packet")
        #expect(metadata[PDFDocumentAttribute.authorAttribute] as? String == "Packet Team")
        #expect(metadata[PDFDocumentAttribute.subjectAttribute] as? String == "Handover and invoice")
    }

    private func assertDocument(_ output: PDFKit.PDFDocument, matches fixture: CommonDocumentFixture) throws {
        #expect(output.pageCount >= fixture.minimumPages)
        let allText = try #require(output.string)
        let markers = fixture.markerCounts.keys.sorted()
        for marker in markers {
            #expect(allText.components(separatedBy: marker).count - 1 == fixture.markerCounts[marker], "Marker \(marker)")
        }
        for sequence in fixture.orderedSequences {
            let positions = sequence.map { (allText as NSString).range(of: $0).location }
            #expect(!positions.contains(NSNotFound))
            #expect(zip(positions, positions.dropFirst()).allSatisfy { $0 < $1 }, "Sequence \(sequence) at \(positions)")
        }
        let attributes = try #require(output.documentAttributes)
        #expect(attributes[PDFDocumentAttribute.titleAttribute] as? String == fixture.document.info.title)
        var markerPositions: [String: (page: Int, bounds: CGRect)] = [:]
        for index in 0..<output.pageCount {
            let page = try #require(output.page(at: index))
            let positions = try assertPage(page, index: index, totalPages: output.pageCount, fixture: fixture, markers: markers)
            for (marker, bounds) in positions where markerPositions[marker] == nil {
                markerPositions[marker] = (index, bounds)
            }
        }
        for transition in fixture.verticalTransitions {
            let earlier = try #require(markerPositions[transition.earlier])
            let later = try #require(markerPositions[transition.later])
            #expect(earlier.page <= later.page)
            if earlier.page == later.page {
                #expect(earlier.bounds.minY >= later.bounds.maxY, "\(transition.later) must stay below \(transition.earlier)")
            }
        }
    }

    private func assertPage(
        _ page: PDFPage, index: Int, totalPages: Int, fixture: CommonDocumentFixture, markers: [String]
    ) throws -> [String: CGRect] {
        var markerPositions: [String: CGRect] = [:]
        let text = try #require(page.string)
        #expect(text.components(separatedBy: "COMMON HEADER").count - 1 == 1, "Header on page \(index)")
        #expect(text.components(separatedBy: "PAGE\(index + 1)OF\(totalPages)").count - 1 == 1)
        let pageBounds = page.bounds(for: .mediaBox)
        #expect(abs(pageBounds.width - fixture.document.layout.width) < 0.01)
        #expect(abs(pageBounds.height - fixture.document.layout.height) < 0.01)
        let pageMarkers = markers.filter { text.contains($0) }
        #expect(!pageMarkers.isEmpty, "Page \(index) must have body content")
        for marker in pageMarkers {
            let range = (text as NSString).range(of: marker)
            let selection = try #require(page.selection(for: range))
            let bounds = selection.bounds(for: page)
            markerPositions[marker] = bounds
            let margin = fixture.document.layout.margin
            let contentBounds = CGRect(x: margin.left, y: margin.bottom,
                                       width: pageBounds.width - margin.left - margin.right,
                                       height: pageBounds.height - margin.top - margin.bottom)
            #expect(contentBounds.insetBy(dx: -1, dy: -2).contains(bounds), "Bounds for \(marker) on page \(index): \(bounds)")
            if let limits = fixture.horizontalLimits[marker] {
                #expect(bounds.minX >= limits.min - 0.01, "Left column limit for \(marker)")
                #expect(bounds.maxX <= limits.max + 0.01, "Right column limit for \(marker)")
            }
        }
        for marker in [pageMarkers.first, pageMarkers.last].compactMap({ $0 }) {
            let selection = try #require(page.selection(for: (text as NSString).range(of: marker)))
            #expect(try darkPixels(on: page, in: selection.bounds(for: page)) > 5, "Visible ink for \(marker) on page \(index)")
        }
        if let marker = fixture.linkMarker, text.contains(marker) {
            let links = page.annotations.filter { $0.url?.absoluteString == "https://github.com/techprimate/TPPDF" }
            let selection = try #require(page.selection(for: (text as NSString).range(of: marker)))
            #expect(!links.isEmpty)
            #expect(links.contains { $0.bounds.intersects(selection.bounds(for: page)) })
        }
        return markerPositions
    }

    private func darkPixels(on page: PDFPage, in bounds: CGRect) throws -> Int {
        let crop = bounds.insetBy(dx: -2, dy: -2).integral
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
            Int(bytes[$0]) + Int(bytes[$0 + 1]) + Int(bytes[$0 + 2]) < 300
        }.count
    }
}
#endif
