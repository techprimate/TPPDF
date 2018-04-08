//
//  PDFJSONRepresentable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFJSONRepresentable_Spec: QuickSpec {

    override func spec() {
        describe("PDFJSONRepresentable") {

            context("variables") {

                it("has a computed JSONRepresentable") {
                    class CustomJSON: PDFJSONRepresentable {

                        var JSONRepresentation: AnyObject {
                            return "EXAMPLE" as AnyObject
                        }
                    }

                    let instance = CustomJSON()
                    expect(instance.JSONRepresentation as? String) == "EXAMPLE"
                }
            }
        }
    }

}
