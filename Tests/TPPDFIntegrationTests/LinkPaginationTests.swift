//
//  LinkPaginationTests.swift
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

struct LinkPaginationTests {
    @Test(arguments: [0, 1, 2], [
        (mixedFonts: false, debug: false), (false, true), (true, false), (true, true),
    ])
    func wrappedLinkAnnotationsCoverLinkedTextButNotItsUnlinkedNeighbors(
        alignmentIndex: Int, scenario: (mixedFonts: Bool, debug: Bool)
    ) throws {
        // Arrange
        let document = TPPDF.PDFDocument(layout: PDFPageLayout(
            size: CGSize(width: 220, height: 180), margin: EdgeInsets(top: 20, left: 20, bottom: 20, right: 20), space: (0, 0)
        ))
        let markers = (0..<40).map { "LINK\($0)END" }
        let linkedText = markers.joined(separator: " ")
        let text = NSMutableAttributedString(string: "PREFIX🙂\n" + linkedText + "\nAFTERLINK",
                                             attributes: [.font: Font.systemFont(ofSize: 12)])
        let url = "https://github.com/techprimate/TPPDF"
        text.addAttribute(.link, value: url, range: (text.string as NSString).range(of: linkedText))
        if scenario.mixedFonts {
            text.addAttribute(.font, value: Font.systemFont(ofSize: 20), range: (text.string as NSString).range(of: "LINK10END"))
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = [.left, .center, .right][alignmentIndex]
        text.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        document.add(attributedText: text)
        let generator = PDFGenerator(document: document)
        generator.debug = scenario.debug

        // Act
        let data = try generator.generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)

        // Assert
        #expect(output.pageCount > 1)
        #expect(generator.totalPages == output.pageCount)
        let allText = try #require(output.string)
        for marker in markers { #expect(allText.components(separatedBy: marker).count - 1 == 1) }
        var annotationCount = 0
        for index in 0..<output.pageCount {
            let page = try #require(output.page(at: index))
            let pageText = try #require(page.string)
            let links = page.annotations.filter { $0.url?.absoluteString == url }
            annotationCount += links.count
            #expect(links.allSatisfy { page.bounds(for: .mediaBox).contains($0.bounds) })
            for marker in markers where pageText.contains(marker) {
                let range = (pageText as NSString).range(of: marker)
                let selection = try #require(page.selection(for: range))
                let bounds = selection.bounds(for: page)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                #expect(links.contains { $0.bounds.contains(center) }, "Annotation for \(marker) on page \(index)")
            }
            for marker in ["PREFIX", "AFTERLINK"] where pageText.contains(marker) {
                let selection = try #require(page.selection(for: (pageText as NSString).range(of: marker)))
                let bounds = selection.bounds(for: page)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                #expect(!links.contains { $0.bounds.contains(center) }, "Unlinked neighbor \(marker) on page \(index)")
            }
        }
        #expect(annotationCount > 1)
    }
}
#endif
