//
//  TextPaginationTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct TextPaginationTests {
    @Test(arguments: [false, true], [false, true])
    func multipageTextPreservesEveryLineInOrderWithHeadersAndFooters(attributed: Bool, debug: Bool) throws {
        // Arrange
        let layout = PDFPageLayout(size: CGSize(width: 280, height: 200),
                                   margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                                   space: (header: 5, footer: 5))
        let document = TPPDF.PDFDocument(layout: layout)
        document.add(.headerLeft, text: "HEADER")
        document.add(.footerRight, text: "FOOTER")
        let expectedLines = (0..<100).map { String(format: "LINE%03d", $0) }
        let text = expectedLines.joined(separator: "\n")
        if attributed {
            document.add(attributedText: NSAttributedString(string: text, attributes: [.font: Font.systemFont(ofSize: 12)]))
        } else {
            document.set(font: Font.systemFont(ofSize: 12))
            document.add(text: text)
        }
        let generator = PDFGenerator(document: document)
        generator.debug = debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(output.pageCount > 1)
        #expect(generator.totalPages == output.pageCount)
        var actualLines: [String] = []
        for index in 0..<output.pageCount {
            let page = try #require(output.page(at: index))
            let pageText = try #require(page.string)
            let lines = pageText.components(separatedBy: .newlines)
            #expect(lines.filter { $0 == "HEADER" }.count == 1)
            #expect(lines.filter { $0 == "FOOTER" }.count == 1)
            let bodyLines = lines.filter { $0.hasPrefix("LINE") }
            #expect(!bodyLines.isEmpty, "Page \(index) must not be blank")
            actualLines += bodyLines
        }
        #expect(actualLines == expectedLines)
    }
}
#endif
