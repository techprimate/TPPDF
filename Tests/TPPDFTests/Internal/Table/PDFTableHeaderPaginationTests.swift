//
//  PDFTableHeaderPaginationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFTableHeaderPaginationTests {
    @Test(arguments: [0, 1, 2])
    func configuredHeaderRowsRepeatWithTheirCustomStyles(styledColumns: Int) throws {
        let table = makeTable(rows: 60, headerRows: 2)
        let customStyle = PDFTableCellStyle(colors: (.blue, .white), font: Font.systemFont(ofSize: 16))
        for row in 0..<2 {
            for column in 0..<styledColumns {
                table[row, column].style = customStyle
            }
        }
        let generator = PDFGenerator(document: PDFDocument(format: .a4))

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)
        let pages = slicesByPage(result)

        #expect(pages.count > 1)
        for page in pages.dropFirst() {
            try #require(page.count >= 5)
            #expect(text(in: page[0]) == "cell-0-0")
            #expect(text(in: page[1]) == "cell-0-1")
            #expect(text(in: page[2]) == "cell-1-0")
            #expect(text(in: page[3]) == "cell-1-1")
            #expect(abs(page[4].frame.minY - page[3].frame.maxY - 3) < 0.001)
            for row in 0..<2 {
                for column in 0..<styledColumns {
                    let slice = page[row * 2 + column]
                    let background = try #require(slice.children.compactMap { $0 as? PDFRectangleObject }.first)
                    let content = try #require(slice.children.compactMap { $0 as? PDFAttributedTextObject }.first)
                    let attributes = try #require(content.attributedText?.text.attributes(at: 0, effectiveRange: nil))
                    #expect(background.fillColor == customStyle.colors.fill)
                    #expect(attributes[.font] as? Font == customStyle.font)
                    #expect(attributes[.foregroundColor] as? Color == customStyle.colors.text)
                }
            }
        }
    }

    @Test(arguments: [0, 2])
    func tablesWithoutColumnHeadersKeepBodyCellsOnEveryPage(rowHeaderColumns: Int) throws {
        let table = makeTable(rows: 60, headerRows: 0)
        table.style.rowHeaderCount = rowHeaderColumns
        let generator = PDFGenerator(document: PDFDocument(format: .a4))

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)
        let pages = slicesByPage(result)

        #expect(pages.count > 1)
        #expect(pages.flatMap { $0 }.count == 120)
        for page in pages {
            #expect(!page.isEmpty)
            for slice in page {
                #expect(slice.frame.minY >= generator.layout.margin.top)
                #expect(slice.frame.maxY <= generator.document.layout.height - generator.layout.margin.bottom)
                #expect(slice.frame.height > 0)
            }
        }
    }

    @Test func headerOnlyTableFitsWithoutAddingASecondPage() throws {
        let table = makeTable(rows: 2, headerRows: 2)
        table[0, 0].style = PDFTableCellStyle(colors: (.blue, .white))
        let generator = PDFGenerator(document: PDFDocument(format: .a4))

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)

        #expect(!result.contains { $0.1 is PDFPageBreakObject })
        #expect(result.filter { $0.1 is PDFSlicedObject }.count == 4)
    }

    @Test func disabledHeaderRepetitionDoesNotRepeatCustomHeaderText() throws {
        let table = makeTable(rows: 60, headerRows: 1)
        table.showHeadersOnEveryPage = false
        table[0, 0].style = PDFTableCellStyle(colors: (.blue, .white))
        let generator = PDFGenerator(document: PDFDocument(format: .a4))

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)
        let pages = slicesByPage(result)

        #expect(pages.count > 1)
        #expect(pages.flatMap { $0 }.filter { text(in: $0) == "cell-0-0" }.count == 1)
    }

    @Test(arguments: [1, 2], [false, true])
    func headerAndFirstBodyRowMoveTogether(headerRows: Int, headersFit: Bool) throws {
        let table = makeTable(rows: headerRows + 2, headerRows: headerRows)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        let remainingHeight: CGFloat = headersFit ? CGFloat(headerRows * 26 + 14) : 10
        _ = try PDFSpaceObject(space: availableHeight - remainingHeight).calculate(generator: generator, container: .contentLeft)

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)
        let pages = slicesByPage(result)

        #expect(result.first?.1 is PDFPageBreakObject)
        try #require(pages.count == 2)
        #expect(pages[0].isEmpty)
        #expect(pages[1].count == (headerRows + 2) * 2)
        for row in 0..<(headerRows + 2) {
            for column in 0..<2 {
                #expect(pages[1].filter { text(in: $0) == "cell-\(row)-\(column)" }.count == 1)
            }
        }
    }

    @Test(arguments: [1, 2])
    func headerAndBodyRowsStayWhenTheyFit(headerRows: Int) throws {
        let table = makeTable(rows: headerRows + 2, headerRows: headerRows)
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        _ = try PDFSpaceObject(space: availableHeight - 150).calculate(generator: generator, container: .contentLeft)

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)

        #expect(!result.contains { $0.1 is PDFPageBreakObject })
        #expect(result.filter { $0.1 is PDFSlicedObject }.count == (headerRows + 2) * 2)
    }

    @Test func enabledCellSplittingStillUsesTheRemainingSpace() throws {
        let table = makeTable(rows: 3, headerRows: 1)
        table.shouldSplitCellsOnPageBreak = true
        let generator = PDFGenerator(document: PDFDocument(format: .a4))
        let availableHeight = PDFCalculations.calculateAvailableFrameHeight(for: generator, in: .contentLeft)
        _ = try PDFSpaceObject(space: availableHeight - 40).calculate(generator: generator, container: .contentLeft)

        let result = try PDFTableObject(table: table).calculate(generator: generator, container: .contentLeft)
        let pages = slicesByPage(result)

        #expect(!(result.first?.1 is PDFPageBreakObject))
        try #require(!pages.isEmpty)
        #expect(pages[0].contains { text(in: $0) == "cell-0-0" })
        #expect(pages[0].contains { text(in: $0) == "cell-1-0" })
    }

    private func makeTable(rows: Int, headerRows: Int) -> PDFTable {
        let table = PDFTable(rows: rows, columns: 2)
        let style = PDFTableCellStyle(font: Font.systemFont(ofSize: 12))
        table.style = PDFTableStyle(rowHeaderCount: 0, columnHeaderCount: headerRows, footerCount: 0,
                                    columnHeaderStyle: style, contentStyle: style)
        table.padding = 4
        table.margin = 3
        table.showHeadersOnEveryPage = true
        for row in 0..<rows {
            for column in 0..<2 {
                table[row, column].content = "cell-\(row)-\(column)".asTableContent
            }
        }
        return table
    }

    private func slicesByPage(_ objects: [PDFLocatedRenderObject]) -> [[PDFSlicedObject]] {
        var pages: [[PDFSlicedObject]] = [[]]
        for (_, object) in objects {
            if object is PDFPageBreakObject {
                pages.append([])
            } else if let slice = object as? PDFSlicedObject {
                pages[pages.count - 1].append(slice)
            }
        }
        return pages
    }

    private func text(in slice: PDFSlicedObject) -> String? {
        slice.children.compactMap { ($0 as? PDFAttributedTextObject)?.attributedText?.text.string }.first
    }
}
