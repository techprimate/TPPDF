//
//  DocumentHeaderTableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Foundation
import Testing
@testable import TPPDF

#if canImport(PDFKit)
import PDFKit

struct DocumentHeaderTableTests {
    @Test func headerTableAfterBannerRendersLikeAnUnclippedContentTable() throws {
        let base64 =
            "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAK"
            + "ACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs"
            + "+EJ+/8AAEQgAAQABAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQ"
            + "USITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6"
            + "g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQ"
            + "EBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoW"
            + "JDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztL"
            + "W2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMABgYGBgYGCgYGCg4KCgoOEg4ODg4SFxISEhISFxwXFxcXFxcc"
            + "HBwcHBwcHCIiIiIiIicnJycnLCwsLCwsLCwsLP/bAEMBBwcHCwoLEwoKEy4fGh8uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi"
            + "4uLi4uLi4uLi4uLi4uLv/dAAQAAf/aAAwDAQACEQMRAD8A6+iiivxY/Sz/2Q=="
        let imageData = try #require(Data(base64Encoded: base64))
        let image = try #require(Image(data: imageData))
        let document = TPPDF.PDFDocument(format: .a4)
        document.add(.headerLeft, image: PDFImage(image: image, size: CGSize(width: 180, height: 60)))
        document.add(.headerLeft, table: makeTable(image: image))
        document.add(text: "BODY TEXT")

        let reference = TPPDF.PDFDocument(format: .a4)
        reference.add(space: 60)
        reference.add(table: makeTable(image: image))

        let actualPixels = try tablePixels(in: document)
        let expectedPixels = try tablePixels(in: reference)

        #expect(expectedPixels.contains { $0 < 250 })
        #expect(actualPixels == expectedPixels)
    }

    private func makeTable(image: Image) -> PDFTable {
        let table = PDFTable(rows: 1, columns: 2)
        table.widths = [0.1, 0.9]
        table.style = PDFTableStyle(
            rowHeaderCount: 0, columnHeaderCount: 0, footerCount: 0,
            contentStyle: PDFTableCellStyle(borders: .none, font: Font.systemFont(ofSize: 28))
        )
        table[0, 0].content = image.asTableContent
        table[0, 1].content = "HEADER TEXT".asTableContent
        return table
    }

    private func tablePixels(in document: TPPDF.PDFDocument) throws -> Data {
        let data = try PDFGenerator(document: document).generateData()
        let outputDocument = PDFKit.PDFDocument(data: data)
        let output = try #require(outputDocument)
        #expect(output.pageCount == 1)
        let page = try #require(output.page(at: 0))
        let text = try #require(page.string)
        #expect(text.contains("HEADER TEXT"))
        let context = try #require(CGContext(
            data: nil, width: 450, height: 40, bitsPerComponent: 8, bytesPerRow: 450 * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ))
        context.setFillColor(gray: 1, alpha: 1)
        context.fill(CGRect(x: 0, y: 0, width: 450, height: 40))
        // The table starts at x=70, y=130 in top-down document coordinates.
        context.translateBy(x: -70, y: -(document.layout.height - 170))
        page.draw(with: .mediaBox, to: context)
        let pixels = try #require(context.data)
        return Data(bytes: pixels, count: context.bytesPerRow * context.height)
    }
}
#endif
