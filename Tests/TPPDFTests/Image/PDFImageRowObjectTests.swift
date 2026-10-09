//
//  PDFImageRowObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFImageRowObjectTests {
    @Test(arguments: [0, 1, 2])
    func imageRowsRestoreBothIndents(alignmentIndex: Int) throws {
        let container: PDFContainer = [.contentLeft, .contentCenter, .contentRight][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        generator.layout.indentation.setLeft(indentation: 120, in: container)
        generator.layout.indentation.setRight(indentation: 30, in: container)
        let row = PDFImageRowObject(images: images(count: 3), spacing: 2)

        _ = try row.calculate(generator: generator, container: container)

        #expect(generator.layout.indentation.leftIn(container: container) == 120)
        #expect(generator.layout.indentation.rightIn(container: container) == 30)
    }

    @Test(arguments: [1, 5])
    func imageGroupAndFollowingContentStayInsideSectionColumn(imageCount: Int) throws {
        let document = PDFDocument(format: .a4)
        let generator = PDFGenerator(document: document)
        let section = PDFSection(columnWidths: [0.4, 0.4])
        section.columnMargin = 0
        let group = PDFGroup(backgroundColor: .purple, padding: EdgeInsets(top: 0, left: 8, bottom: 0, right: 0))
        group.add(space: 8)
        group.add(.left, imagesInRow: images(count: imageCount), spacing: 2)
        group.add(space: 8)
        section.columns[1].add(group: group)
        section.columns[1].add(text: "Following text")

        let availableWidth = document.layout.width - document.layout.margin.left - document.layout.margin.right
        let columnMinX = document.layout.margin.left + availableWidth * 0.4
        let columnMaxX = columnMinX + availableWidth * 0.4
        let result = try PDFSectionObject(section: section).calculate(generator: generator, container: .contentLeft)
        let groupObject = try #require(result.compactMap { $0.1 as? PDFGroupObject }.first)
        let textObject = try #require(result.compactMap { $0.1 as? PDFAttributedTextObject }.first)

        #expect(abs(groupObject.frame.minX - columnMinX) < 0.001)
        #expect(groupObject.frame.maxX <= columnMaxX + 0.001)
        #expect(abs(textObject.frame.minX - columnMinX) < 0.001)
        #expect(textObject.frame.maxX <= columnMaxX + 0.001)
        #expect(result.filter { $0.1 is PDFImageObject }.count == imageCount)
    }

    private func images(count: Int) -> [PDFImage] {
        (0..<count).map { _ in
            PDFImage(image: Image(), size: CGSize(width: 51, height: 51), options: [])
        }
    }
}
