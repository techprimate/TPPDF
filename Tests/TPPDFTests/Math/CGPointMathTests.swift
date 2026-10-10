//
//  CGPointMathTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.05.2017.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import CoreGraphics
import Testing
@testable import TPPDF

struct CGPointMathTests {
    @Test func addingPointsAddsBothCoordinates() {
        // Arrange
        let point = CGPoint(x: 10, y: 20)
        let otherPoint = CGPoint(x: 30, y: 40)

        // Act
        let result = point + otherPoint

        // Assert
        #expect(result == CGPoint(x: 40, y: 60))
    }

    @Test func subtractingPointsSubtractsBothCoordinates() {
        // Arrange
        let point = CGPoint(x: 10, y: 20)
        let otherPoint = CGPoint(x: 30, y: 40)

        // Act
        let result = point - otherPoint

        // Assert
        #expect(result == CGPoint(x: -20, y: -20))
    }

    @Test func addingScalarAddsToBothCoordinates() {
        // Arrange
        let point = CGPoint(x: 10, y: 20)
        let value: CGFloat = 20

        // Act
        let result = point + value

        // Assert
        #expect(result == CGPoint(x: 30, y: 40))
    }
}
