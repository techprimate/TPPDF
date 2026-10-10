//
//  PDFPageFormatNameConstantsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageFormatNameConstantsTests {
    @Test(arguments: [
        ("us.half-letter", "US Half Letter"),
        ("us.letter", "US Letter"),
        ("us.legal", "US Legal"),
        ("us.junior-legal", "US Junior Legal"),
        ("us.ledger", "US Ledger"),
        ("ansi.a", "ANSI A"),
        ("ansi.b", "ANSI B"),
        ("ansi.c", "ANSI C"),
        ("ansi.d", "ANSI D"),
        ("ansi.e", "ANSI E"),
        ("a0", "A0"),
        ("a1", "A1"),
        ("a2", "A2"),
        ("a3", "A3"),
        ("a4", "A4"),
        ("a5", "A5"),
        ("a6", "A6"),
        ("a7", "A7"),
        ("a8", "A8"),
        ("a9", "A9"),
        ("a10", "A10"),
        ("b0", "B0"),
        ("b1", "B1"),
        ("b2", "B2"),
        ("b3", "B3"),
        ("b4", "B4"),
        ("b5", "B5"),
        ("b6", "B6"),
        ("b7", "B7"),
        ("b8", "B8"),
        ("b9", "B9"),
        ("b10", "B10"),
        ("c0", "C0"),
        ("c1", "C1"),
        ("c2", "C2"),
        ("c3", "C3"),
        ("c4", "C4"),
        ("c5", "C5"),
        ("c6", "C6"),
        ("c7", "C7"),
        ("c8", "C8"),
        ("c9", "C9"),
        ("c10", "C10"),
    ])
    func formatsHaveExpectedNames(formatName: String, expectedName: String) throws {
        // Arrange
        let pageFormat = try #require(PDFPageFormat(rawValue: formatName))

        // Act
        let name = pageFormat.name

        // Assert
        #expect(name == expectedName)
    }
}
