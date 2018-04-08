//
//  UIColor+Hex_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class UIColor_Hex_Spec: QuickSpec {

    override func spec() {
        describe("UIColor+Hex") {

            it("can be initalized with three digit hex") {
                let color = try? UIColor(hex: "3F0")
                expect(color) == UIColor(red: 0.2, green: 1.0, blue: 0, alpha: 1)
            }

            it("can be initalized with four digit hex") {
                let color = try? UIColor(hex: "3F0C")
                expect(color) == UIColor(red: 0.2, green: 1.0, blue: 0, alpha: 0.8)
            }

            it("can be initalized with six digit hex") {
                let color = try? UIColor(hex: "FF00FF")
                expect(color) == UIColor.magenta
            }

            it("can be initalized with eight digit hex") {
                let color = try? UIColor(hex: "FFFF0000")
                expect(color) == UIColor.yellow.withAlphaComponent(0.0)
            }

            it("can not be initalized with other length") {
                expect {
                    try UIColor(hex: "1234567890")
                }.to(throwError())
            }

            it("can not be initalized with invalid hexadecimal characters") {
                expect {
                    try UIColor(hex: "%")
                }.to(throwError())
            }

            it("can be converted to hexadecimal string") {
                expect(UIColor.orange.hex) == "#ff7f00"
                expect(UIColor.orange.withAlphaComponent(0.5).hex) == "#ff7f007f"
            }
        }
    }

}
