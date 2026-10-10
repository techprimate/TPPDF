//
//  PDFPageFormatSizeConstantsTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageFormatSizeConstantsTests {
    @Test(arguments: [
        ("us.half-letter", CGSize(width: 396, height: 612)),
        ("us.letter", CGSize(width: 612, height: 792)),
        ("us.legal", CGSize(width: 612, height: 1008)),
        ("us.junior-legal", CGSize(width: 360, height: 576)),
        ("us.ledger", CGSize(width: 792, height: 1224)),
        ("ansi.a", CGSize(width: 612, height: 792)),
        ("ansi.b", CGSize(width: 792, height: 1224)),
        ("ansi.c", CGSize(width: 1224, height: 1584)),
        ("ansi.d", CGSize(width: 1584, height: 2448)),
        ("ansi.e", CGSize(width: 2448, height: 3168)),
        ("a0", CGSize(width: 2384, height: 3370)),
        ("a1", CGSize(width: 1684, height: 2384)),
        ("a2", CGSize(width: 1191, height: 1684)),
        ("a3", CGSize(width: 842, height: 1191)),
        ("a4", CGSize(width: 595, height: 842)),
        ("a5", CGSize(width: 420, height: 595)),
        ("a6", CGSize(width: 298, height: 420)),
        ("a7", CGSize(width: 210, height: 298)),
        ("a8", CGSize(width: 147, height: 210)),
        ("a9", CGSize(width: 105, height: 147)),
        ("a10", CGSize(width: 74, height: 105)),
        ("b0", CGSize(width: 2834, height: 4008)),
        ("b1", CGSize(width: 2004, height: 2834)),
        ("b2", CGSize(width: 1417, height: 2004)),
        ("b3", CGSize(width: 1001, height: 1417)),
        ("b4", CGSize(width: 709, height: 1001)),
        ("b5", CGSize(width: 499, height: 709)),
        ("b6", CGSize(width: 354, height: 499)),
        ("b7", CGSize(width: 249, height: 354)),
        ("b8", CGSize(width: 176, height: 249)),
        ("b9", CGSize(width: 125, height: 176)),
        ("b10", CGSize(width: 88, height: 125)),
        ("c0", CGSize(width: 2599, height: 3677)),
        ("c1", CGSize(width: 1837, height: 2599)),
        ("c2", CGSize(width: 1298, height: 1837)),
        ("c3", CGSize(width: 918, height: 1298)),
        ("c4", CGSize(width: 649, height: 918)),
        ("c5", CGSize(width: 459, height: 649)),
        ("c6", CGSize(width: 323, height: 459)),
        ("c7", CGSize(width: 230, height: 323)),
        ("c8", CGSize(width: 162, height: 230)),
        ("c9", CGSize(width: 113, height: 162)),
        ("c10", CGSize(width: 79, height: 113)),
    ])
    func formatsHaveExpectedSizes(formatName: String, expectedSize: CGSize) throws {
        // Arrange
        let pageFormat = try #require(PDFPageFormat(rawValue: formatName))

        // Act
        let size = pageFormat.size

        // Assert
        #expect(size == expectedSize)
    }
}
