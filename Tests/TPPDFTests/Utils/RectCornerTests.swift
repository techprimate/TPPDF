//
//  RectCornerTests.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 2025-12-29.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if !os(iOS) && !os(tvOS) && !os(watchOS) && !os(visionOS)
import Testing
@testable import TPPDF

@Suite("RectCorner Tests")
struct RectCornerTests {
    @Test("Individual corner raw values are correct")
    func testIndividualCornerRawValues() {
        #expect(RectCorner.topLeft.rawValue == 1)  // 1 << 0 = 0b0001
        #expect(RectCorner.topRight.rawValue == 2) // 1 << 1 = 0b0010
        #expect(RectCorner.bottomLeft.rawValue == 4) // 1 << 2 = 0b0100
        #expect(RectCorner.bottomRight.rawValue == 8) // 1 << 3 = 0b1000
    }

    @Test("allCorners raw value is correct")
    func testAllCornersRawValue() {
        // allCorners should be (1 << 4) - 1 = 16 - 1 = 15 = 0b1111
        #expect(RectCorner.allCorners.rawValue == 15)
    }

    @Test("allCorners contains all individual corners")
    func testAllCornersContainsAllCorners() {
        #expect(RectCorner.allCorners.contains(.topLeft))
        #expect(RectCorner.allCorners.contains(.topRight))
        #expect(RectCorner.allCorners.contains(.bottomLeft))
        #expect(RectCorner.allCorners.contains(.bottomRight))
    }

    @Test("Can combine corners using OptionSet operations")
    func testCombineCorners() {
        let topCorners: RectCorner = [.topLeft, .topRight]
        #expect(topCorners.contains(.topLeft))
        #expect(topCorners.contains(.topRight))
        #expect(!topCorners.contains(.bottomLeft))
        #expect(!topCorners.contains(.bottomRight))

        let bottomCorners: RectCorner = [.bottomLeft, .bottomRight]
        #expect(bottomCorners.contains(.bottomLeft))
        #expect(bottomCorners.contains(.bottomRight))
        #expect(!bottomCorners.contains(.topLeft))
        #expect(!bottomCorners.contains(.topRight))
    }

    @Test("Can create RectCorner from raw value")
    func testInitFromRawValue() {
        let corner = RectCorner(rawValue: 1)
        #expect(corner.rawValue == 1)
        #expect(corner == .topLeft)

        let allCornersFromRaw = RectCorner(rawValue: 15)
        #expect(allCornersFromRaw.rawValue == 15)
        #expect(allCornersFromRaw == .allCorners)
    }

    @Test("Union of all individual corners equals allCorners")
    func testUnionEqualsAllCorners() {
        let combined: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        #expect(combined.rawValue == RectCorner.allCorners.rawValue)
        #expect(combined == .allCorners)
    }
}
#endif
