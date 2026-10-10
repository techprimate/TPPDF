//
//  PDFInfoEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 27.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFInfoEquatableTests {
    @Test func defaultMetadataIsEqual() {
        // Arrange
        let info = PDFInfo()
        let otherInfo = PDFInfo()

        // Act
        let isEqual = info == otherInfo

        // Assert
        #expect(isEqual)
    }

    @Test(arguments: ["title", "author", "subject", "keywords", "ownerPassword", "userPassword", "allowsPrinting", "allowsCopying"])
    func changingMetadataMakesItUnequal(property: String) {
        // Arrange
        let info = PDFInfo()
        let otherInfo = PDFInfo()
        switch property {
        case "title": otherInfo.title = "OTHER"
        case "author": otherInfo.author = "OTHER"
        case "subject": otherInfo.subject = "OTHER"
        case "keywords": otherInfo.keywords = ["OTHER"]
        case "ownerPassword": otherInfo.ownerPassword = "OTHER"
        case "userPassword": otherInfo.userPassword = "OTHER"
        case "allowsPrinting": otherInfo.allowsPrinting = false
        default: otherInfo.allowsCopying = false
        }

        // Act
        let isEqual = info == otherInfo

        // Assert
        #expect(!isEqual)
    }
}
