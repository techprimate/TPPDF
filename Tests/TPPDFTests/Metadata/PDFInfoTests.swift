//
//  PDFInfoTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFInfoTests {
    @Test func initializesWithDefaultMetadataAndPermissions() {
        // Arrange
        let expectedKeywords = ["tppdf", "pdf", "generator"]

        // Act
        let info = PDFInfo()

        // Assert
        #expect(info.title == "Title")
        #expect(info.author == "Author")
        #expect(info.subject == "Subject")
        #expect(info.keywords == expectedKeywords)
        #expect(info.ownerPassword == nil)
        #expect(info.userPassword == nil)
        #expect(info.allowsPrinting)
        #expect(info.allowsCopying)
    }

    @Test func generatesMetadataWithConfiguredPasswordsAndPermissions() {
        // Arrange
        let info = PDFInfo()
        info.ownerPassword = "1234"
        info.userPassword = "ABCD"
        info.allowsPrinting = false

        // Act
        let metadata = info.generate()

        // Assert
        #expect(metadata[kCGPDFContextTitle as String] as? String == "Title")
        #expect(metadata[kCGPDFContextAuthor as String] as? String == "Author")
        #expect(metadata[kCGPDFContextSubject as String] as? String == "Subject")
        #expect(metadata[kCGPDFContextKeywords as String] as? [String] == ["tppdf", "pdf", "generator"])
        #expect(metadata[kCGPDFContextAllowsPrinting as String] as? Bool == false)
        #expect(metadata[kCGPDFContextAllowsCopying as String] as? Bool == true)
        #expect(metadata[kCGPDFContextOwnerPassword as String] as? String == "1234")
        #expect(metadata[kCGPDFContextUserPassword as String] as? String == "ABCD")
        #expect((metadata[kCGPDFContextCreator as String] as? String ?? "").hasPrefix("xctest"))
    }
}
