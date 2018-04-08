//
//  PDFPageFormat_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPageFormat_Spec: QuickSpec {

    override func spec() {
        describe("PDFPageFormat") {

            context("size") {

                it("falls back to correct size") {
                    expect(PDFPageFormat.c0.usSize) == PDFPageFormat.c0.size
                    expect(PDFPageFormat.c0.ansiSize) == PDFPageFormat.c0.size
                    expect(PDFPageFormat.c0.aSize) == PDFPageFormat.c0.size
                    expect(PDFPageFormat.c0.bSize) == PDFPageFormat.c0.size
                    expect(PDFPageFormat.usLegal.cSize) == PDFPageFormat.usLegal.size
                }

                it("can be rotated to landscape") {
                    expect(PDFPageFormat.a0.landscapeSize) == CGSize(
                        width: PDFPageFormat.a0.size.height,
                        height: PDFPageFormat.a0.size.width
                    )
                }
            }
        }
    }

}
