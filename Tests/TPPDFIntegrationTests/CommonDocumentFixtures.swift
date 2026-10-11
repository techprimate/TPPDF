//
//  CommonDocumentFixtures.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

// Original, synthetic office documents. No third-party templates or personal data are used.
struct CommonDocumentFixture {
    enum Kind: String, CaseIterable {
        case report, invoice, resume, newsletter, letter, agenda
    }

    enum Paper: CaseIterable {
        case a4, letter, landscape

        var layout: PDFPageLayout {
            switch self {
            case .a4: return PDFPageFormat.a4.layout
            case .letter: return PDFPageFormat.usLetter.layout
            case .landscape:
                var layout = PDFPageFormat.a4.layout
                layout.size = PDFPageFormat.a4.landscapeSize
                return layout
            }
        }
    }

    let document: PDFDocument
    let markerCounts: [String: Int]
    let orderedSequences: [[String]]
    let minimumPages: Int
    var linkMarker: String?
    var verticalTransitions: [(earlier: String, later: String)] = []
    var horizontalLimits: [String: (min: CGFloat, max: CGFloat)] = [:]

    static func make(_ kind: Kind, paper: Paper) throws -> CommonDocumentFixture {
        let document = PDFDocument(layout: paper.layout)
        document.layout.margin = EdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        document.info = PDFInfo(title: "Common \(kind.rawValue)", author: "Fixture Team", subject: "Document regression")
        document.set(font: Font.systemFont(ofSize: 12))
        document.set(.headerLeft, font: Font.systemFont(ofSize: 10))
        document.add(.headerLeft, text: "COMMON HEADER")
        document.pagination = PDFPagination(container: .footerRight, style: .customClosure { page, total in
            "PAGE\(page)OF\(total)"
        }, textAttributes: [.font: Font.systemFont(ofSize: 10)])
        switch kind {
        case .report: return report(document)
        case .invoice: return invoice(document)
        case .resume: return try resume(document)
        case .newsletter: return newsletter(document)
        case .letter: return letter(document)
        case .agenda: return agenda(document)
        }
    }

    private static func report(_ document: PDFDocument) -> CommonDocumentFixture {
        let heading = document.add(style: PDFTextStyle(name: "Report heading", font: Font.boldSystemFont(ofSize: 18), color: .black))
        let subheading = document.add(style: PDFTextStyle(name: "Report subheading", font: Font.boldSystemFont(ofSize: 14), color: .black))
        document.add(text: "REPORTTITLE Quarterly delivery report")
        document.add(space: 12)
        document.add(tableOfContent: PDFTableOfContent(styles: [heading, subheading], symbol: .none))
        document.createNewPage()
        var counts = ["REPORTTITLE": 1, "RPTINTRO": 2, "RPTDETAIL": 2, "RPTRISKS": 2]
        let sections = [("RPTINTRO", heading), ("RPTDETAIL", subheading), ("RPTRISKS", heading)]
        var sequence: [String] = []
        for (sectionIndex, section) in sections.enumerated() {
            document.add(textObject: PDFSimpleText(text: section.0 + " Delivery review", style: section.1))
            let markers = (0..<18).map { "RPT\(sectionIndex)P\($0)END" }
            let paragraphs = markers.map {
                $0 + " The team reviewed delivery quality, customer needs, and operating risks. "
                    + "The next milestone has a clear owner and measurable acceptance criteria."
            }
            document.add(text: paragraphs.joined(separator: "\n"))
            document.add(space: 12)
            for marker in markers { counts[marker] = 1 }
            sequence += markers
        }
        return .init(document: document, markerCounts: counts, orderedSequences: [sequence], minimumPages: 3)
    }

    private static func invoice(_ document: PDFDocument) -> CommonDocumentFixture {
        document.add(text: "INVOICETITLE Services invoice")
        let address = PDFGroup(backgroundColor: Color(white: 0.95, alpha: 1), padding: EdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        address.add(text: "BILLTO Fictional client department")
        address.add(text: "INVOICEREF Reference 2026-001")
        document.add(group: address)
        let table = PDFTable(rows: 67, columns: 3)
        table.widths = [0.55, 0.15, 0.3]
        let style = PDFTableCellStyle(font: Font.systemFont(ofSize: 11))
        table.style = PDFTableStyle(rowHeaderCount: 0, columnHeaderCount: 1, footerCount: 1,
                                    columnHeaderStyle: PDFTableCellStyle(colors: (.blue, .white), font: Font.boldSystemFont(ofSize: 11)),
                                    footerStyle: style, contentStyle: style)
        table.padding = 5
        table.margin = 2
        table.showHeadersOnEveryPage = true
        table.shouldSplitCellsOnPageBreak = false
        table.content = [["ITEM", "QTY", "AMOUNT"]]
            + (0..<65).map { ["INV\($0)END Consulting service", "1", "100.00"] }
            + [["INVOICETOTAL", "65", "6500.00"]]
        document.add(table: table)
        document.add(text: "PAYMENTTERMS Payment due in thirty days")
        let markers = (0..<65).map { "INV\($0)END" }
        var counts = Dictionary(uniqueKeysWithValues: markers.map { ($0, 1) })
        for marker in ["INVOICETITLE", "BILLTO", "INVOICEREF", "INVOICETOTAL", "PAYMENTTERMS"] { counts[marker] = 1 }
        return .init(document: document, markerCounts: counts, orderedSequences: [markers + ["INVOICETOTAL", "PAYMENTTERMS"]], minimumPages: 2)
    }

    private static func resume(_ document: PDFDocument) throws -> CommonDocumentFixture {
        document.add(text: "RESUMETITLE Fictional candidate")
        document.add(space: 12)
        let section = PDFSection(columnWidths: [0.3, 0.7])
        section.columnMargin = 20
        section.columns[0].backgroundColor = Color(red: 0.9, green: 0.95, blue: 1, alpha: 1)
        let profile = PDFGroup(padding: EdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        profile.add(.center, image: try image(size: CGSize(width: 60, height: 60)))
        profile.add(text: "PROFILE Team-focused specialist")
        let skills = PDFList(indentations: [(pre: 0, past: 12), (pre: 8, past: 12)])
        skills.addItem(PDFListItem(symbol: .dot, content: "SKILLONE Planning")
            .addItem(PDFListItem(symbol: .dash, content: "SKILLTWO Delivery")))
        skills.addItem(PDFListItem(symbol: .dot, content: "SKILLTHREE Communication"))
        profile.add(list: skills)
        section.columns[0].add(group: profile)
        let experiences = (0..<12).map { "JOB\($0)END" }
        for marker in experiences {
            section.columns[1].add(text: marker + " Project specialist")
            section.columns[1].add(text: "Led a small team and reviewed delivery outcomes.")
            section.columns[1].add(space: 10)
        }
        document.add(section: section)
        document.add(text: "REFERENCES Available on request")
        var counts = Dictionary(uniqueKeysWithValues: experiences.map { ($0, 1) })
        for marker in ["RESUMETITLE", "PROFILE", "SKILLONE", "SKILLTWO", "SKILLTHREE", "REFERENCES"] { counts[marker] = 1 }
        let leftMax = 40 + (document.layout.width - 100) * 0.3
        let leftMarkers = ["PROFILE", "SKILLONE", "SKILLTWO", "SKILLTHREE"]
        var limits = Dictionary(uniqueKeysWithValues: leftMarkers.map { ($0, (min: CGFloat(40), max: leftMax)) })
        for marker in experiences { limits[marker] = (min: leftMax + 20, max: document.layout.width - 40) }
        return .init(document: document, markerCounts: counts,
                     orderedSequences: [["PROFILE", "SKILLONE", "SKILLTWO", "SKILLTHREE"], experiences + ["REFERENCES"]], minimumPages: 1,
                     verticalTransitions: [("JOB11END", "REFERENCES")], horizontalLimits: limits)
    }

    private static func newsletter(_ document: PDFDocument) -> CommonDocumentFixture {
        document.add(text: "NEWSLETTERTITLE Monthly team news")
        document.add(space: 12)
        document.enable(columns: 2, widths: [0.5, 0.5], spacings: [18])
        let markers = (0..<160).map { "NEWS\($0)END" }
        document.add(text: markers.map { $0 + " Team update. Delivery remained stable and the next milestone is ready." }.joined(separator: "\n"))
        document.disableColumns(addPageBreak: true)
        document.add(text: "NEWSLETTEREND Next issue in one month")
        var counts = Dictionary(uniqueKeysWithValues: markers.map { ($0, 1) })
        counts["NEWSLETTERTITLE"] = 1
        counts["NEWSLETTEREND"] = 1
        return .init(document: document, markerCounts: counts, orderedSequences: [markers + ["NEWSLETTEREND"]], minimumPages: 2)
    }

    private static func letter(_ document: PDFDocument) -> CommonDocumentFixture {
        document.add(text: "LETTERTITLE Project handover")
        document.add(space: 12)
        document.add(text: "SALUTATION Dear project team,")
        let markers = (0..<12).map { "LETTER\($0)END" }
        document.add(text: markers.map { $0 + " Please review the delivery notes and confirm the next milestone." }.joined(separator: "\n"))
        let link = NSAttributedString(string: "PROJECTLINK Project resources", attributes: [
            .font: Font.systemFont(ofSize: 12), .link: "https://github.com/techprimate/TPPDF",
        ])
        document.add(attributedText: link)
        let signature = PDFGroup(allowsBreaks: false, padding: EdgeInsets(top: 10, left: 8, bottom: 10, right: 8))
        signature.add(text: "SIGNATURE Kind regards, Fixture Team")
        document.add(group: signature)
        var counts = Dictionary(uniqueKeysWithValues: markers.map { ($0, 1) })
        for marker in ["LETTERTITLE", "SALUTATION", "PROJECTLINK", "SIGNATURE"] { counts[marker] = 1 }
        return .init(document: document, markerCounts: counts,
                     orderedSequences: [["SALUTATION"] + markers + ["PROJECTLINK", "SIGNATURE"]], minimumPages: 1, linkMarker: "PROJECTLINK")
    }

    private static func agenda(_ document: PDFDocument) -> CommonDocumentFixture {
        document.add(text: "AGENDATITLE Delivery workshop")
        let table = PDFTable(rows: 12, columns: 3)
        table.widths = [0.2, 0.5, 0.3]
        let style = PDFTableCellStyle(font: Font.systemFont(ofSize: 11))
        table.style = PDFTableStyle(rowHeaderCount: 0, columnHeaderCount: 1, footerCount: 0,
                                    columnHeaderStyle: style, contentStyle: style)
        table.padding = 6
        table.content = [["SESSION", "TOPIC", "OWNER"]]
            + (0..<11).map { ["SESSION\($0)END", "TOPIC\($0)END Delivery review", "Team"] }
        table[rows: 1..<4, column: 0].merge()
        document.add(table: table)
        let actions = PDFList(indentations: [(pre: 0, past: 12), (pre: 10, past: 12)])
        actions.addItem(PDFListItem(symbol: .numbered(value: "1"), content: "ACTIONONE Confirm owner")
            .addItem(PDFListItem(symbol: .dash, content: "ACTIONTWO Confirm deadline")))
        actions.addItem(PDFListItem(symbol: .numbered(value: "2"), content: "ACTIONTHREE Share notes"))
        let summary = PDFGroup(allowsBreaks: false, backgroundColor: Color(white: 0.95, alpha: 1),
                               padding: EdgeInsets(top: 10, left: 12, bottom: 10, right: 12))
        summary.add(list: actions)
        document.add(group: summary)
        document.add(text: "AGENDAEND Workshop completed")
        let topics = (0..<11).map { "TOPIC\($0)END" }
        var counts = Dictionary(uniqueKeysWithValues: topics.map { ($0, 1) })
        for marker in ["AGENDATITLE", "SESSION0END", "ACTIONONE", "ACTIONTWO", "ACTIONTHREE", "AGENDAEND"] { counts[marker] = 1 }
        for row in 4..<11 { counts["SESSION\(row)END"] = 1 }
        return .init(document: document, markerCounts: counts,
                     orderedSequences: [topics, ["ACTIONONE", "ACTIONTWO", "ACTIONTHREE", "AGENDAEND"]], minimumPages: 1,
                     verticalTransitions: [("TOPIC10END", "ACTIONONE")])
    }

    static func image(size: CGSize, color: CGColor = CGColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1)) throws -> PDFImage {
        let context = try #require(PDFContextGraphics.createBitmapContext(size: size))
        context.setFillColor(color)
        context.fill(CGRect(origin: .zero, size: size))
        let image = try #require(PDFContextGraphics.getImage(from: context, size: size))
        return PDFImage(image: image, size: size, options: .none)
    }
}
