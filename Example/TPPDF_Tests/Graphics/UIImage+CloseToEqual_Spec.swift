//
//  UIImage+CloseToEqual_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 16/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class UIImage_CloseToEqual_Spec: QuickSpec {

    override func spec() {
        describe("UIImage") {

            let color = UIColor(red: 0.8, green: 0.7, blue: 0.6, alpha: 0.5)

            context("CloseToEqual") {

                it("is close to equal if difference is smaller than delta") {
                    let otherColor = UIColor(red: 0.79999, green: 0.69999, blue: 0.59999, alpha: 0.49999)
                    expect(color.isClose(to: otherColor, decimals: 5)).to(beTrue())

                    let secondOtherColor = UIColor(red: 0.80001, green: 0.70001, blue: 0.60001, alpha: 0.50001)
                    expect(color.isClose(to: secondOtherColor, decimals: 5)).to(beTrue())
                }

                it("is not close to equal if red difference is smaller than delta") {
                    let otherColor = UIColor(red: 0.79998, green: 0.7, blue: 0.6, alpha: 0.5)
                    expect(color.isClose(to: otherColor, decimals: 5)).to(beFalse())
                }

                it("is not close to equal if green difference is smaller than delta") {
                    let otherColor = UIColor(red: 0.8, green: 0.69998, blue: 0.6, alpha: 0.5)
                    expect(color.isClose(to: otherColor, decimals: 5)).to(beFalse())
                }

                it("is not close to equal if blue difference is smaller than delta") {
                    let otherColor = UIColor(red: 0.8, green: 0.7, blue: 0.59998, alpha: 0.5)
                    expect(color.isClose(to: otherColor, decimals: 5)).to(beFalse())
                }

                it("is not close to equal if alpha difference is smaller than delta") {
                    let otherColor = UIColor(red: 0.8, green: 0.7, blue: 0.6, alpha: 0.49998)
                    expect(color.isClose(to: otherColor, decimals: 5)).to(beFalse())
                }
            }
        }
    }

}
