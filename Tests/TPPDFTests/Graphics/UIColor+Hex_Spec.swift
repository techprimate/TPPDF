//
//  Color+Hex_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class Color_Hex_Spec: QuickSpec {

    override func spec() {
        describe("Color+Hex") {

            it("can be initialized with three digit hex") {
                let color = try? Color(hex: "3F0")
                expect(color) == Color(red: 0.2, green: 1.0, blue: 0, alpha: 1)
            }

            it("can be initialized with four digit hex") {
                let color = try? Color(hex: "3F0C")
                expect(color) == Color(red: 0.2, green: 1.0, blue: 0, alpha: 0.8)
            }

            it("can be initialized with six digit hex") {
                let color = try? Color(hex: "FF00FF")
                expect(color) == Color.magenta
            }

            it("can be initialized with eight digit hex") {
                let color = try? Color(hex: "FFFF0000")
                expect(color) == Color.yellow.withAlphaComponent(0.0)
            }

            it("can not be initialized with other length") {
                expect {
                    try Color(hex: "1234567890")
                }.to(throwError())
            }

            it("can not be initialized with invalid hexadecimal characters") {
                expect {
                    try Color(hex: "%")
                }.to(throwError())
            }

            it("can be converted to hexadecimal string") {
                expect(Color.orange.hex) == "#ff7f00"
                expect(Color.orange.withAlphaComponent(0.5).hex) == "#ff7f007f"
            }
        }
    }

}
