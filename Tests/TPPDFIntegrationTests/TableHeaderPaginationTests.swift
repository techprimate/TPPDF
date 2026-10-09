//
//  TableHeaderPaginationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct TableHeaderPaginationTests {
    @Test(arguments: [0, 1], [0, 1, 2])
    func generatedPagesPreserveHeadersAndAllBodyText(headerRows: Int, styledColumns: Int) throws {
        let table = PDFTable(rows: 60, columns: 2)
        let style = PDFTableCellStyle(font: Font.systemFont(ofSize: 12))
        table.style = PDFTableStyle(rowHeaderCount: 0, columnHeaderCount: headerRows, footerCount: 0,
                                    columnHeaderStyle: style, contentStyle: style)
        table.padding = 4
        table.showHeadersOnEveryPage = true
        for row in 0..<60 {
            for column in 0..<2 {
                let suffix = column == 0 ? "A" : "B"
                let value = row < headerRows ? "HEADER\(suffix)" : "ROW\(row)\(suffix)END"
                table[row, column].content = value.asTableContent
            }
        }
        for column in 0..<styledColumns {
            table[0, column].style = PDFTableCellStyle(colors: (.blue, .white), font: Font.systemFont(ofSize: 16))
        }
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(table: table)

        let data = try PDFGenerator(document: document).generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)
        #expect(output.pageCount > 1)
        var pages: [String] = []
        for index in 0..<output.pageCount {
            let page = try #require(output.page(at: index))
            let text = try #require(page.string)
            #expect(text.contains("ROW"))
            if headerRows > 0 {
                #expect(text.contains("HEADERA"))
                #expect(text.contains("HEADERB"))
            }
            pages.append(text)
        }
        let allText = pages.joined(separator: "\n")
        for row in headerRows..<60 {
            for column in 0..<2 {
                let suffix = column == 0 ? "A" : "B"
                let marker = "ROW\(row)\(suffix)END"
                #expect(allText.components(separatedBy: marker).count - 1 == 1)
            }
        }
    }
}
#endif
