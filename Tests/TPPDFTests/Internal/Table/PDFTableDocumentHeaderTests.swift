//
//  PDFTableDocumentHeaderTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFTableDocumentHeaderTests {
    @Test(arguments: [0, 1, 2], [0, 1])
    func tableAfterHeaderImageIsNotClipped(alignmentIndex: Int, headerRows: Int) throws {
        let container: PDFContainer = [.headerLeft, .headerCenter, .headerRight][alignmentIndex]
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let banner = PDFImageObject(image: PDFImage(image: Image(), size: CGSize(width: 180, height: 60)))
        _ = try banner.calculate(generator: generator, container: container)
        let table = makeTable(headerRows: headerRows)

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: container)
        let slice = try #require(result.compactMap { $0.1 as? PDFSlicedObject }.first)
        let background = try #require(slice.children.compactMap { $0 as? PDFRectangleObject }.first)

        #expect(slice.frame == background.frame)
        #expect(slice.frame.minY == banner.frame.maxY)
        #expect(generator.layout.heights.value(for: container) == 60 + slice.frame.height)
        #expect(!result.contains { $0.1 is PDFPageBreakObject })
    }

    @Test func tallerNeighboringHeaderDoesNotClipTheTable() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        _ = try PDFSpaceObject(space: 200).calculate(generator: generator, container: .headerRight)

        let result = try PDFTableObject(table: makeTable(headerRows: 0)).calculate(
            generator: generator, container: .headerLeft
        )
        let slice = try #require(result.compactMap { $0.1 as? PDFSlicedObject }.first)
        let background = try #require(slice.children.compactMap { $0 as? PDFRectangleObject }.first)

        #expect(slice.frame == background.frame)
        #expect(slice.frame.minY == generator.layout.margin.top)
    }

    @Test func contentTableStillStartsBelowTheDocumentHeader() throws {
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        _ = try PDFSpaceObject(space: 60).calculate(generator: generator, container: .headerLeft)

        let result = try PDFTableObject(table: makeTable(headerRows: 0)).calculate(
            generator: generator, container: .contentLeft
        )
        let slice = try #require(result.compactMap { $0.1 as? PDFSlicedObject }.first)
        let background = try #require(slice.children.compactMap { $0 as? PDFRectangleObject }.first)

        #expect(slice.frame == background.frame)
        #expect(slice.frame.minY == generator.layout.margin.top + 60 + generator.document.layout.space.header)
    }

    private func makeTable(headerRows: Int) -> PDFTable {
        let table = PDFTable(rows: 1, columns: 1)
        let style = PDFTableCellStyle(font: Font.systemFont(ofSize: 28))
        table.style = PDFTableStyle(rowHeaderCount: 0, columnHeaderCount: headerRows, footerCount: 0,
                                    columnHeaderStyle: style, contentStyle: style)
        table[0, 0].content = "HEADER TEXT".asTableContent
        return table
    }
}
