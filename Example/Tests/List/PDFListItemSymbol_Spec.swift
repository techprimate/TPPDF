//
//  PDFListItemSymbol_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFListItemSymbol_Spec : QuickSpec {

    override func spec() {
        describe("PDFListItemSymbol") {

            it("should have enum values") {
                expect(PDFListItemSymbol.none).toNot(beNil())
                expect(PDFListItemSymbol.inherit).toNot(beNil())
                expect(PDFListItemSymbol.dot).toNot(beNil())
                expect(PDFListItemSymbol.dash).toNot(beNil())
                expect(PDFListItemSymbol.custom(value: "%@")).toNot(beNil())
                expect(PDFListItemSymbol.numbered(value: "%@")).toNot(beNil())
            }

            it("has a string value") {
                expect(PDFListItemSymbol.none.stringValue) == ""
                expect(PDFListItemSymbol.inherit.stringValue) == ""
                expect(PDFListItemSymbol.dot.stringValue) == "\u{00B7}"
                expect(PDFListItemSymbol.dash.stringValue) == "-"
                expect(PDFListItemSymbol.custom(value: "%@").stringValue) == "%@"
                expect(PDFListItemSymbol.numbered(value: "%@").stringValue) == "%@."
            }

            it("has String as RawValue") {
                expect(type(of: PDFListItemSymbol.RawValue.self) == type(of: String.self)).to(beTrue())
            }

            it("has a custom raw value") {
                expect(PDFListItemSymbol.none.rawValue) == "none"
                expect(PDFListItemSymbol.inherit.rawValue) == "inherit"
                expect(PDFListItemSymbol.dot.rawValue) == "dot"
                expect(PDFListItemSymbol.dash.rawValue) == "dash"
                expect(PDFListItemSymbol.custom(value: "%@").rawValue) == "custom|%@"
                expect(PDFListItemSymbol.numbered(value: "%@").rawValue) == "numbered|%@"
                expect(PDFListItemSymbol.numbered(value: nil).rawValue) == "numbered|nil"
            }

            it("can be initalized with raw value") {
                expect(PDFListItemSymbol(rawValue: "none")?.rawValue) == PDFListItemSymbol.none.rawValue
                expect(PDFListItemSymbol(rawValue: "inherit")?.rawValue) == PDFListItemSymbol.inherit.rawValue
                expect(PDFListItemSymbol(rawValue: "dot")?.rawValue) == PDFListItemSymbol.dot.rawValue
                expect(PDFListItemSymbol(rawValue: "dash")?.rawValue) == PDFListItemSymbol.dash.rawValue
                expect(PDFListItemSymbol(rawValue: "")?.rawValue) == PDFListItemSymbol.none.rawValue
                expect(PDFListItemSymbol(rawValue: "|")?.rawValue) == PDFListItemSymbol.none.rawValue
                expect(PDFListItemSymbol(rawValue: "||")?.rawValue) == PDFListItemSymbol.none.rawValue
                expect(PDFListItemSymbol(rawValue: "asdf|")?.rawValue) == PDFListItemSymbol.none.rawValue
                expect(PDFListItemSymbol(rawValue: "custom|")?.rawValue) == PDFListItemSymbol.custom(value: "").rawValue
                expect(PDFListItemSymbol(rawValue: "custom|%@")?.rawValue) == PDFListItemSymbol.custom(value: "%@").rawValue
                expect(PDFListItemSymbol(rawValue: "numbered|")?.rawValue) == PDFListItemSymbol.numbered(value: "").rawValue
                expect(PDFListItemSymbol(rawValue: "numbered|nil")?.rawValue) == PDFListItemSymbol.numbered(value: nil).rawValue
                expect(PDFListItemSymbol(rawValue: "numbered|%@")?.rawValue) == PDFListItemSymbol.numbered(value: "%@").rawValue
            }

            context("JSONRepresentation") {

                it("can be represented") {
                    expect(PDFListItemSymbol.none.JSONRepresentation as? String) == PDFListItemSymbol.none.rawValue
                    expect(PDFListItemSymbol.inherit.JSONRepresentation as? String) == PDFListItemSymbol.inherit.rawValue
                    expect(PDFListItemSymbol.dot.JSONRepresentation as? String) == PDFListItemSymbol.dot.rawValue
                    expect(PDFListItemSymbol.dash.JSONRepresentation as? String) == PDFListItemSymbol.dash.rawValue
                    expect(PDFListItemSymbol.custom(value: "%@").JSONRepresentation as? String) == PDFListItemSymbol.custom(value: "%@").rawValue
                    expect(PDFListItemSymbol.numbered(value: "%@").JSONRepresentation as? String) == PDFListItemSymbol.numbered(value: "%@").rawValue
                }
            }
        }
    }

}
