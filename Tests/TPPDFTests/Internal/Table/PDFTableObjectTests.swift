//
//  PDFTableObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05.12.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit

struct PDFTableObjectTests {
    @Test(arguments: [false, true])
    func unmergedRowsAcrossPagesPreserveFramesAndConfiguredHeaderRepetition(repeatHeaders: Bool) throws {
        // Arrange
        let columns = 4
        let table = makeTable()
        table.showHeadersOnEveryPage = repeatHeaders
        let generator = PDFGenerator(document: .init(format: .a4))
        let object = PDFTableObject(table: table)
        let columnXPositions: [CGFloat] = [70, 117.5, 260, 402.5]
        let columnWidths: [CGFloat] = [27.5, 122.5, 122.5, 122.5]
        #if targetEnvironment(macCatalyst)
        let firstPagePositions: [CGFloat] = [70, 117, 164, 211, 258, 305, 352, 399, 446, 493, 540, 600, 660, 720]
        let secondPagePositions: [CGFloat] = repeatHeaders
            ? [70, 117, 164, 211, 271, 331, 391, 451, 511]
            : [70, 130, 190, 250, 310, 370]
        let largeRowHeight: CGFloat = 50
        #else
        let firstPagePositions: [CGFloat] = [70, 117, 164, 211, 258, 305, 352, 399, 446, 493, 540, 598, 656, 714]
        let secondPagePositions: [CGFloat] = repeatHeaders
            ? [70, 117, 164, 211, 269, 327, 385, 443, 501]
            : [70, 128, 186, 244, 302, 360]
        let largeRowHeight: CGFloat = 48
        #endif
        let rowYPositions = firstPagePositions + secondPagePositions
        let firstPageHeights = Array(repeating: CGFloat(37), count: 10) + Array(repeating: largeRowHeight, count: 4)
        let secondPageHeights = (repeatHeaders ? Array(repeating: CGFloat(37), count: 3) : [])
            + Array(repeating: largeRowHeight, count: 6)
        let rowHeights = firstPageHeights + secondPageHeights
        let expectedCount = 80 + 2 /* Outlines */ + 1 /* Page break */ + (repeatHeaders ? 12 : 0)

        // Act
        let result = try object.calculate(generator: generator, container: .contentLeft)

        // Assert
        try #require(result.count == expectedCount)
        #expect(result[56].1 is PDFRectangleObject)
        #expect(result[57].1 is PDFPageBreakObject)
        for row in rowYPositions.indices {
            for column in columnXPositions.indices {
                let offset = row >= 14 ? 2 /* First page outline and page break */ : 0
                let frame = result[row * columns + column + offset].1.frame
                #expect(frame.origin.x == columnXPositions[column], "Cell \(row),\(column) has invalid x position")
                #expect(frame.origin.y == rowYPositions[row], "Cell \(row),\(column) has invalid y position")
                #expect(frame.width == columnWidths[column], "Cell \(row),\(column) has invalid width")
                #expect(frame.height == rowHeights[row], "Cell \(row),\(column) has invalid height")
            }
        }
    }

    private func makeTable() -> PDFTable {
        let table = PDFTable(rows: 20, columns: 4)
        table.widths = [0.1, 0.3, 0.3, 0.3]
        table.margin = 10
        table.padding = 10
        table.shouldSplitCellsOnPageBreak = false
        table.style.columnHeaderCount = 3
        for row in 0..<20 {
            table[row, 0].content = "\(row)".asTableContent
            for column in 1..<4 {
                table[row, column].content = "\(row),\(column)".asTableContent
            }
        }
        return table
    }
}
#endif
