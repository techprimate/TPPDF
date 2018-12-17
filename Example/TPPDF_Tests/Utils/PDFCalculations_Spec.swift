//
//  PDFCalculations_Spec.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 02/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFCalculations_Spec : QuickSpec {

    override func spec() {
        describe("PDFCalculations") {

            context("calculate text frame and remainder") {

                it("should return correct frame and remainder") {
                    let attributedString = NSAttributedString(string: "12345\n12345\n12345\n12345\n12345")

                    var bounds = CGSize(width: 100, height: 100)
                    var (text, size, remainder) = PDFCalculations.calculateTextSizeAndRemainder(of: attributedString, in: bounds)

                    expect(text) == NSAttributedString(string: "12345\n12345\n12345\n12345\n12345")
                    expect(size.width).to(beCloseTo(33.369140625, within: 0.00001))
                    expect(size.height) == 75.0
                    expect(remainder).to(beNil())

                    bounds = CGSize(width: 10, height: 200)
                    (text, size, remainder) = PDFCalculations.calculateTextSizeAndRemainder(of: attributedString, in: bounds)

                    expect(text) == NSAttributedString(string: "12345\n12345\n123")
                    expect(size.width).to(beCloseTo(6.673828125, within: 0.00001))
                    expect(size.height) == 195.0
                    expect(remainder) == NSAttributedString(string: "45\n12345\n12345")

                    bounds = CGSize(width: 200, height: 20)
                    (text, size, remainder) = PDFCalculations.calculateTextSizeAndRemainder(of: attributedString, in: bounds)

                    expect(text) == NSAttributedString(string: "12345\n")
                    expect(size.width).to(beCloseTo(33.369140625, within: 0.00001))
                    expect(size.height) == 15.0
                    expect(remainder) == NSAttributedString(string: "12345\n12345\n12345\n12345")

                    bounds = CGSize(width: 20, height: 20)
                    (text, size, remainder) = PDFCalculations.calculateTextSizeAndRemainder(of: attributedString, in: bounds)

                    expect(text) == NSAttributedString(string: "12")
                    expect(size.width).to(beCloseTo(13.34765625, within: 0.00001))
                    expect(size.height) == 15.0
                    expect(remainder) == NSAttributedString(string: "345\n12345\n12345\n12345\n12345")
                }
            }
        }
    }

}
