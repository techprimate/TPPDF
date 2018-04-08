//
//  PDFGenerator+Layout_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFGenerator_Layout_Spec: QuickSpec {

    override func spec() {
        describe("PDFGenerator+Layout") {

            let document = PDFDocument(format: .a4)
            let generator = PDFGenerator(document: document)

            let container = PDFContainer.contentCenter

            it("can get the current content offset of a container") {
                expect(generator.getContentOffset(in: container)) == generator.layout.getContentOffset(in: container)
            }

            it("can set the current content offset of a container") {
                let newValue: CGFloat = 20.0

                generator.setContentOffset(in: container, to: newValue)
                expect(generator.getContentOffset(in: container)) == newValue
            }
        }
    }

}
