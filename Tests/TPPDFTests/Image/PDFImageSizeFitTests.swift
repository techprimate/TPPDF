//
//  PDFImageSizeFitTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.13.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Testing
@testable import TPPDF

struct PDFImageSizeFitTests {
    @Test(arguments: [0, 1, 2])
    func initializingImagePreservesEachFittingMode(modeIndex: Int) {
        // Arrange
        let fittingModes: [PDFImageSizeFit] = [.width, .height, .widthHeight]
        let fittingMode = fittingModes[modeIndex]
        let image = Image()

        // Act
        let pdfImage = PDFImage(image: image, sizeFit: fittingMode)

        // Assert
        #expect(pdfImage.sizeFit == fittingMode)
    }
}
