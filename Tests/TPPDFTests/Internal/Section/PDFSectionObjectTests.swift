//
//  PDFSectionObjectTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFSectionObjectTests {
    @Test func backgroundsCoverWholePageBeforeUnevenColumnContent() {
        let tallText = PDFRenderObject(frame: CGRect(x: 0, y: 10, width: 40, height: 60))
        let shortText = PDFRenderObject(frame: CGRect(x: 50, y: 10, width: 40, height: 20))
        let padding = PDFRenderObject(frame: CGRect(x: 0, y: 70, width: 40, height: 5))
        let shortPadding = PDFRenderObject(frame: CGRect(x: 50, y: 30, width: 40, height: 5))
        let result = merge([
            0: [(.contentLeft, tallText), (.contentLeft, padding)],
            1: [(.contentLeft, shortText), (.contentLeft, shortPadding)],
        ])

        #expect(result.count == 6)
        #expect(result.prefix(2).allSatisfy { $0.1 is PDFRectangleObject })
        #expect(result[0].1.frame == CGRect(x: 0, y: 10, width: 40, height: 65))
        #expect(result[1].1.frame == CGRect(x: 50, y: 10, width: 40, height: 65))
        #expect(result[2].1 === tallText)
        #expect(result[3].1 === padding)
        #expect(result[4].1 === shortText)
        #expect(result[5].1 === shortPadding)
    }

    @Test func backgroundsStayBehindContentAcrossUnequalPageCounts() throws {
        let firstPage = PDFRenderObject(frame: CGRect(x: 0, y: 10, width: 40, height: 60))
        let secondPage = PDFRenderObject(frame: CGRect(x: 0, y: 5, width: 40, height: 20))
        let thirdPage = PDFRenderObject(frame: CGRect(x: 0, y: 5, width: 40, height: 30))
        let shortColumn = PDFRenderObject(frame: CGRect(x: 50, y: 10, width: 40, height: 20))
        let result = merge([
            0: [(.contentLeft, firstPage), (.contentLeft, PDFPageBreakObject()),
                (.contentLeft, secondPage), (.contentLeft, PDFPageBreakObject()), (.contentLeft, thirdPage)],
            1: [(.contentLeft, shortColumn)],
        ])

        try #require(result.count == 10)
        #expect(result[4].1 is PDFPageBreakObject)
        #expect(result[5].1 is PDFRectangleObject)
        #expect(result[5].1.frame == CGRect(x: 0, y: 5, width: 40, height: 20))
        #expect(result[6].1 === secondPage)
        #expect(result[7].1 is PDFPageBreakObject)
        #expect(result[8].1.frame == CGRect(x: 0, y: 5, width: 40, height: 30))
        #expect(result[9].1 === thirdPage)
    }

    @Test func contentWithoutBackgroundPreservesNonDrawingObjects() throws {
        let state = PDFRenderObject()
        let text = PDFRenderObject(frame: CGRect(x: 0, y: 10, width: 40, height: 20))
        let object = PDFSectionObject(section: PDFSection(columnWidths: [1]))
        let result = object.calulatePageBreakPositions(
            [0: [(.contentLeft, state), (.contentRight, text)]],
            metadata: [.init(minX: 0, width: 40, backgroundColor: nil)],
            container: .contentLeft
        )
        try #require(result.count == 2)
        #expect(result[0].1 === state)
        #expect(result[1].1 === text)
        #expect(result[1].0 == .contentRight)
    }

    private func merge(_ columns: [Int: [PDFLocatedRenderObject]]) -> [PDFLocatedRenderObject] {
        PDFSectionObject(section: PDFSection(columnWidths: [0.5, 0.5])).calulatePageBreakPositions(
            columns,
            metadata: [
                .init(minX: 0, width: 40, backgroundColor: .gray),
                .init(minX: 50, width: 40, backgroundColor: .gray),
            ],
            container: .contentLeft
        )
    }
}
