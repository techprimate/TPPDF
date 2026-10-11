//
//  PDFDocumentObjectsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.09.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

struct PDFDocumentObjectsTests {
    @Test(arguments: [false, true])
    func addingSpaceUsesDefaultOrExplicitContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let value: CGFloat = 20
        let container: PDFContainer = explicit ? .footerLeft : .contentLeft

        // Act
        if explicit { document.add(.footerLeft, space: value) } else { document.add(space: value) }

        // Assert
        let object = try onlyObject(PDFSpaceObject.self, in: document, container: container)
        #expect(object.space == value)
    }

    @Test(arguments: [false, true])
    func addingLineSeparatorPreservesStyleAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let style = PDFLineStyle(type: .dotted, color: .red, width: 10)
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.addLineSeparator(.headerRight, style: style) } else { document.addLineSeparator(style: style) }

        // Assert
        let object = try onlyObject(PDFLineSeparatorObject.self, in: document, container: container)
        #expect(object.style == style)
    }

    @Test(arguments: [false, true])
    func addingImagePreservesImageAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let image = try loadImage()
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.add(.headerRight, image: image) } else { document.add(image: image) }

        // Assert
        let object = try onlyObject(PDFImageObject.self, in: document, container: container)
        #expect(object.image == image)
    }

    @Test(arguments: [false, true])
    func addingImageRowPreservesImagesSpacingAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let image = try loadImage()
        let images = [image, image, image]
        let spacing: CGFloat = 10
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit {
            document.add(.headerRight, imagesInRow: images, spacing: spacing)
        } else {
            document.add(imagesInRow: images, spacing: spacing)
        }

        // Assert
        let object = try onlyObject(PDFImageRowObject.self, in: document, container: container)
        #expect(object.images == images)
        #expect(object.spacing == spacing)
    }

    @Test(arguments: [false, true])
    func addingSimpleTextPreservesTextAndRequestedSpacing(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let text = "EXAMPLE"
        let spacing: CGFloat = 2.5
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.add(.headerRight, text: text, lineSpacing: spacing) } else { document.add(text: text) }

        // Assert
        let object = try onlyObject(PDFAttributedTextObject.self, in: document, container: container)
        #expect(object.attributedText == nil)
        #expect(object.simpleText?.text == text)
        if explicit { #expect(object.simpleText?.spacing == spacing) }
    }

    @Test(arguments: [false, true])
    func addingAttributedTextPreservesTextAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let text = NSAttributedString(string: "EXAMPLE")
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.add(.headerRight, attributedText: text) } else { document.add(attributedText: text) }

        // Assert
        let object = try onlyObject(PDFAttributedTextObject.self, in: document, container: container)
        #expect(object.attributedText?.text == text)
        #expect(object.simpleText == nil)
    }

    @Test(arguments: [false, true], [false, true])
    func settingOrResettingFontRegistersFontInRequestedContainer(explicit: Bool, reset: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let font = reset ? Font.systemFont(ofSize: PDFConstants.defaultFontSize) : Font.systemFont(ofSize: 20, weight: .bold)
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if reset {
            if explicit { document.resetFont(.headerRight) } else { document.resetFont() }
        } else {
            if explicit { document.set(.headerRight, font: font) } else { document.set(font: font) }
        }

        // Assert
        let object = try onlyObject(PDFFontObject.self, in: document, container: container)
        #expect(object.font == font)
    }

    @Test(arguments: [false, true], [false, true])
    func settingOrResettingTextColorRegistersColorInRequestedContainer(explicit: Bool, reset: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let color = reset ? Color.black : Color.orange
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if reset {
            if explicit { document.resetTextColor(.headerRight) } else { document.resetTextColor() }
        } else {
            if explicit { document.set(.headerRight, textColor: color) } else { document.set(textColor: color) }
        }

        // Assert
        let object = try onlyObject(PDFTextColorObject.self, in: document, container: container)
        #expect(object.color == color)
    }

    @Test(arguments: [false, true])
    func addingTablePreservesTableAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let table = PDFTable(rows: 0, columns: 0)
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.add(.headerRight, table: table) } else { document.add(table: table) }

        // Assert
        let object = try onlyObject(PDFTableObject.self, in: document, container: container)
        #expect(object.table == table)
    }

    @Test(arguments: [false, true])
    func addingListPreservesListAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let list = PDFList(indentations: [(pre: 0, past: 10)])
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.add(.headerRight, list: list) } else { document.add(list: list) }

        // Assert
        let object = try onlyObject(PDFListObject.self, in: document, container: container)
        #expect(object.list == list)
    }

    @Test(arguments: [false, true], [false, true])
    func settingIndentationPreservesValueSideAndContainer(explicit: Bool, left: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let value: CGFloat = 20
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.set(.headerRight, indent: value, left: left) } else { document.set(indent: value, left: left) }

        // Assert
        let object = try onlyObject(PDFIndentationObject.self, in: document, container: container)
        #expect(object.indentation == value)
        #expect(object.left == left)
    }

    @Test(arguments: [false, true])
    func settingAbsoluteOffsetPreservesValueAndContainer(explicit: Bool) throws {
        // Arrange
        let document = PDFDocument(format: .a4)
        let value: CGFloat = 20
        let container: PDFContainer = explicit ? .headerRight : .contentLeft

        // Act
        if explicit { document.set(.headerRight, absoluteOffset: value) } else { document.set(absoluteOffset: value) }

        // Assert
        let object = try onlyObject(PDFOffsetObject.self, in: document, container: container)
        #expect(object.offset == value)
    }

    @Test func creatingNewPageRegistersPageBreakInDefaultContainer() throws {
        // Arrange
        let document = PDFDocument(format: .a4)

        // Act
        document.createNewPage()

        // Assert
        _ = try onlyObject(PDFPageBreakObject.self, in: document, container: .contentLeft)
    }

    private func onlyObject<T: PDFRenderObject>(_ type: T.Type, in document: PDFDocument, container: PDFContainer) throws -> T {
        try #require(document.objects.count == 1)
        #expect(document.objects[0].0 == container)
        return try #require(document.objects[0].1 as? T)
    }

    private func loadImage() throws -> PDFImage {
        let url = try #require(Bundle.module.url(forResource: "image-fixture", withExtension: "jpg"))
        return PDFImage(image: try #require(Image(data: Data(contentsOf: url))))
    }
}
