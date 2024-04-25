//
//  PDFLineStyle_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
import Nimble
import Quick
@testable import TPPDF

class PDFLineStyle_Spec: QuickSpec {
    override func spec() {
        describe("Line Style") {
            var lineStyle: PDFLineStyle!

            let type = PDFLineType.dotted
            let color = Color.orange
            let width: CGFloat = 1.25

            beforeEach {
                lineStyle = PDFLineStyle()
            }

            it("can be initialized with empty initializer") {
                lineStyle = PDFLineStyle()
                expect(lineStyle.type) == PDFLineType.full
                expect(lineStyle.color) == Color.black
                expect(lineStyle.width) == 0.25
            }

            it("can be initialized with values") {
                lineStyle = PDFLineStyle(type: type, color: color, width: width)
                expect(lineStyle.type) == type
                expect(lineStyle.color) == color
                expect(lineStyle.width) == width
            }

            context("variables") {
                beforeEach {
                    lineStyle = PDFLineStyle(type: type, color: color, width: width)
                }

                it("should have a type") {
                    expect(lineStyle.type) == type
                }

                it("should have a color") {
                    expect(lineStyle.color) == color
                }

                it("should have a width") {
                    expect(lineStyle.width) == width
                }
            }

            it("has a static creator of style none") {
                expect(PDFLineStyle.none) == PDFLineStyle(type: .none, color: .black, width: 0)
            }
        }
    }

    static var allTests = [
        ("spec", spec),
    ]
}
