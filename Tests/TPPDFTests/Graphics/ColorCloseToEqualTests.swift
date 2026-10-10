//
//  ColorCloseToEqualTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.16.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct ColorCloseToEqualTests {
    @Test(arguments: [
        (0.79999, 0.69999, 0.59999, 0.49999, true),
        (0.80001, 0.70001, 0.60001, 0.50001, true),
        (0.79998, 0.7, 0.6, 0.5, false),
        (0.8, 0.69998, 0.6, 0.5, false),
        (0.8, 0.7, 0.59998, 0.5, false),
        (0.8, 0.7, 0.6, 0.49998, false),
    ])
    func comparingColorsRespectsToleranceForEachComponent(
        red: Double, green: Double, blue: Double, alpha: Double, expectedCloseness: Bool
    ) {
        // Arrange
        let color = Color(red: 0.8, green: 0.7, blue: 0.6, alpha: 0.5)
        let otherColor = Color(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))

        // Act
        let isClose = color.isClose(to: otherColor, decimals: 5)

        // Assert
        #expect(isClose == expectedCloseness)
    }
}
