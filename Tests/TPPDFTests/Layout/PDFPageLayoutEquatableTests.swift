//
//  PDFPageLayoutEquatableTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.14.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct PDFPageLayoutEquatableTests {
    @Test(arguments: ["same", "size", "margin", "space"])
    func equalityDependsOnSizeMarginsAndSpacing(property: String) {
        // Arrange
        var layout = PDFPageLayout()
        var otherLayout = PDFPageLayout()
        switch property {
        case "size":
            layout.size = CGSize(width: 50, height: 10)
            otherLayout.size = CGSize(width: 20, height: 30)
        case "margin":
            layout.margin = EdgeInsets(top: 40, left: 30, bottom: 20, right: 10)
            otherLayout.margin = EdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        case "space":
            layout.space.footer = 150
            otherLayout.space.footer = 100
        default: break
        }

        // Act
        let isEqual = layout == otherLayout

        // Assert
        #expect(isEqual == (property == "same"))
    }
}
