//
//  PDFErrorTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.12.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation
import Testing
@testable import TPPDF

struct PDFErrorTests {
    @Test(arguments: [
        (PDFError.tableContentInvalid(value: nil), "Table content is invalid: nil"),
        (.tableIsEmpty, "Table is empty"),
        (.tableStructureInvalid(message: "MESSAGE"), "Table structure invalid: MESSAGE"),
        (.tableIndexOutOfBounds(index: 5, length: 4), "Table index out of bounds: <index: 5, length: 4>"),
        (.textObjectIsNil, "No text object has been set"),
        (.textObjectNotCalculated, "Text object is missing string, maybe not calculated?"),
    ])
    func errorsHaveLocalizedDescriptions(error: PDFError, expectedDescription: String) {
        // Arrange
        let errorToDescribe = error

        // Act
        let description = errorToDescribe.localizedDescription

        // Assert
        #expect(description == expectedDescription)
    }
}
