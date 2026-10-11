//
//  PDFGeneratorGenerationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFGeneratorGenerationTests {
    @Test(arguments: [(false, false), (true, false), (false, true)])
    func generatingURLWritesReadablePDFWithOrWithoutFilenameSuffix(suffix: Bool, debug: Bool) throws {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        generator.debug = debug
        let filename = UUID().uuidString + (suffix ? ".pdf" : "")

        // Act
        let url = try generator.generateURL(filename: filename)
        defer { try? FileManager.default.removeItem(at: url) }
        let data = try Data(contentsOf: url)

        // Assert
        #expect(!data.isEmpty)
        #expect(url.pathExtension == "pdf")
    }

    @Test(arguments: [false, true])
    func generatingDataProducesPDFWithOrWithoutDebugOverlay(debug: Bool) throws {
        // Arrange
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        generator.debug = debug

        // Act
        let data = try generator.generateData()

        // Assert
        #expect(!data.isEmpty)
    }

    @Test func renderingObjectInvokesItsDrawImplementation() throws {
        // Arrange
        let object = DrawingObject()
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let optionalContext = PDFContextGraphics.createBitmapContext(size: CGSize(width: 100, height: 100))
        let context = try #require(optionalContext)
        let wasCalled = object.called

        // Act
        try generator.render(object: object, in: .headerLeft, in: PDFContext(cgContext: context))

        // Assert
        #expect(!wasCalled)
        #expect(object.called)
    }

    @Test(arguments: [("header", 9), ("content", 6), ("footer", 3)])
    func extractingRegionReturnsItsObjects(region: String, expectedCount: Int) {
        // Arrange
        let containers: [PDFContainer] = [
            .headerLeft, .headerLeft, .headerLeft, .headerCenter, .headerCenter, .headerCenter,
            .headerRight, .headerRight, .headerRight, .contentLeft, .contentLeft,
            .contentCenter, .contentCenter, .contentRight, .contentRight, .footerLeft, .footerCenter, .footerRight,
        ]
        let objects: [PDFLocatedRenderObject] = containers.map { ($0, PDFSpaceObject(space: 10)) }

        // Act
        let extracted: [PDFLocatedRenderObject]
        switch region {
        case "header": extracted = PDFGenerator.extractHeaderObjects(objects: objects)
        case "footer": extracted = PDFGenerator.extractFooterObjects(objects: objects)
        default: extracted = PDFGenerator.extractContentObjects(objects: objects)
        }

        // Assert
        #expect(extracted.count == expectedCount)
    }

    @Test func tableOfContentsUsesHeadingStylesAndPreservesNestedLevels() {
        // Arrange
        let document = PDFDocument(format: .a4)
        let heading1 = document.add(style: PDFTextStyle(name: "Heading 1", font: Font.systemFont(ofSize: 25), color: .green))
        let heading2 = document.add(style: PDFTextStyle(name: "Heading 2", font: Font.systemFont(ofSize: 20), color: .red))
        let heading3 = document.add(style: PDFTextStyle(name: "Heading 3", font: Font.systemFont(ofSize: 18), color: .blue))
        let body = document.add(style: PDFTextStyle(name: "Body", font: Font.systemFont(ofSize: 12), color: .orange))
        let styles = [heading1, heading2, heading3].map(WeakPDFTextStyleRef.init(value:))
        let headings = [
            ("Heading 1", heading1), ("Heading 1.1", heading2), ("Heading 2", heading1),
            ("Heading 2.1", heading2), ("Heading 2.1.1", heading3), ("Heading 3", heading1), ("Heading 3.1.1", heading3),
        ]
        let textObjects = headings.flatMap { heading in
            [PDFSimpleText(text: heading.0, style: heading.1), PDFSimpleText(text: "Body", style: body),
             PDFSimpleText(text: "Body", style: body)]
        }
        let objects: [PDFLocatedRenderObject] = textObjects.map { (.contentLeft, PDFAttributedTextObject(simpleText: $0)) }
        let expectedList = PDFList(indentations: [(pre: 10, past: 10), (pre: 20, past: 10), (pre: 30, past: 10)])
        expectedList.addItems([
            PDFListItem(symbol: .dot, content: "Heading 1")
                .addItem(PDFListItem(symbol: .dot, content: "Heading 1.1")),
            PDFListItem(symbol: .dot, content: "Heading 2")
                .addItem(PDFListItem(symbol: .dot, content: "Heading 2.1")
                    .addItem(PDFListItem(symbol: .dot, content: "Heading 2.1.1"))),
            PDFListItem(symbol: .dot, content: "Heading 3")
                .addItem(PDFListItem(symbol: .none, content: nil)
                    .addItem(PDFListItem(symbol: .dot, content: "Heading 3.1.1"))),
        ])

        // Act
        let list = withExtendedLifetime(document) {
            PDFGenerator.createTableOfContentList(objects: objects, styles: styles, symbol: .dot)
        }

        // Assert
        #expect(list == expectedList)
    }

    @Test(arguments: [("none", 4), ("after", 5), ("before", 5)])
    func totalPageCountIncludesExternalDocumentAndSurroundingText(position: String, expectedPages: Int) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let url = try #require(Bundle.module.url(forResource: "sample", withExtension: "pdf"))
        if position == "before" { document.add(text: "Some text after document") }
        document.add(externalDocument: .init(url: url))
        if position == "after" { document.add(text: "Some text after document") }
        let generator = PDFGenerator(document: document)

        // Act
        _ = try generator.generateData()

        // Assert
        #expect(generator.totalPages == expectedPages)
    }

    private final class DrawingObject: PDFRenderObject {
        var called = false

        override func draw(generator _: PDFGenerator, container _: PDFContainer, in _: PDFContext) throws {
            called = true
        }
    }
}
