//
//  PDFPageFormat+SizeConstants_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFPageFormat_SizeConstants_Spec: QuickSpec {

    override func spec() {
        describe("PDFPageFormat") {

            context("SizeConstants") {

                context("US Series") {

                    it("has a US Half Letter format") {
                        expect(PDFPageFormat.usHalfLetter.size) == CGSize(width: 396, height: 612)
                    }

                    it("has a US Letter format") {
                        expect(PDFPageFormat.usLetter.size) == CGSize(width: 612, height: 762)
                    }

                    it("has a US Legal format") {
                        expect(PDFPageFormat.usLegal.size) == CGSize(width: 612, height: 1008)
                    }

                    it("has a US Junior Legal format") {
                        expect(PDFPageFormat.usJuniorLegal.size) == CGSize(width: 360, height: 576)
                    }

                    it("has a US Ledger format") {
                        expect(PDFPageFormat.usLedger.size) == CGSize(width: 720, height: 1224)
                    }
                }

                context("ANSI Series") {

                    it("has a ANSI A format") {
                        expect(PDFPageFormat.ansiA.size) == CGSize(width: 612, height: 792)
                    }

                    it("has a ANSI B format") {
                        expect(PDFPageFormat.ansiB.size) == CGSize(width: 792, height: 1224)
                    }

                    it("has a ANSI C format") {
                        expect(PDFPageFormat.ansiC.size) == CGSize(width: 1224, height: 1584)
                    }

                    it("has a ANSI D format") {
                        expect(PDFPageFormat.ansiD.size) == CGSize(width: 1584, height: 2448)
                    }

                    it("has a ANSI E format") {
                        expect(PDFPageFormat.ansiE.size) == CGSize(width: 2448, height: 3168)
                    }
                }

                context("A Series") {

                    it("has a A0 format") {
                        expect(PDFPageFormat.a0.size) == CGSize(width: 2384, height: 3370)
                    }

                    it("has a A1 format") {
                        expect(PDFPageFormat.a1.size) == CGSize(width: 1684, height: 2384)
                    }

                    it("has a A2 format") {
                        expect(PDFPageFormat.a2.size) == CGSize(width: 1191, height: 1684)
                    }

                    it("has a A3 format") {
                        expect(PDFPageFormat.a3.size) == CGSize(width: 842, height: 1191)
                    }

                    it("has a A4 format") {
                        expect(PDFPageFormat.a4.size) == CGSize(width: 595, height: 842)
                    }

                    it("has a A5 format") {
                        expect(PDFPageFormat.a5.size) == CGSize(width: 420, height: 595)
                    }

                    it("has a A6 format") {
                        expect(PDFPageFormat.a6.size) == CGSize(width: 298, height: 420)
                    }

                    it("has a A7 format") {
                        expect(PDFPageFormat.a7.size) == CGSize(width: 210, height: 298)
                    }

                    it("has a A8 format") {
                        expect(PDFPageFormat.a8.size) == CGSize(width: 147, height: 210)
                    }

                    it("has a A9 format") {
                        expect(PDFPageFormat.a9.size) == CGSize(width: 105, height: 147)
                    }

                    it("has a A10 format") {
                        expect(PDFPageFormat.a10.size) == CGSize(width: 74, height: 105)
                    }
                }

                context("B Series") {

                    it("has a B0 format") {
                        expect(PDFPageFormat.b0.size) == CGSize(width: 2834, height: 4008)
                    }

                    it("has a B1 format") {
                        expect(PDFPageFormat.b1.size) == CGSize(width: 2004, height: 2834)
                    }

                    it("has a B2 format") {
                        expect(PDFPageFormat.b2.size) == CGSize(width: 1417, height: 2004)
                    }

                    it("has a B3 format") {
                        expect(PDFPageFormat.b3.size) == CGSize(width: 1001, height: 1417)
                    }

                    it("has a B4 format") {
                        expect(PDFPageFormat.b4.size) == CGSize(width: 709, height: 1001)
                    }

                    it("has a B5 format") {
                        expect(PDFPageFormat.b5.size) == CGSize(width: 499, height: 709)
                    }

                    it("has a B6 format") {
                        expect(PDFPageFormat.b6.size) == CGSize(width: 354, height: 499)
                    }

                    it("has a B7 format") {
                        expect(PDFPageFormat.b7.size) == CGSize(width: 249, height: 354)
                    }

                    it("has a B8 format") {
                        expect(PDFPageFormat.b8.size) == CGSize(width: 176, height: 249)
                    }

                    it("has a B9 format") {
                        expect(PDFPageFormat.b9.size) == CGSize(width: 125, height: 176)
                    }

                    it("has a B10 format") {
                        expect(PDFPageFormat.b10.size) == CGSize(width: 88, height: 125)
                    }
                }

                context("C Series") {

                    it("has a C0 format") {
                        expect(PDFPageFormat.c0.size) == CGSize(width: 2599, height: 3677)
                    }

                    it("has a C1 format") {
                        expect(PDFPageFormat.c1.size) == CGSize(width: 1837, height: 2599)
                    }

                    it("has a C2 format") {
                        expect(PDFPageFormat.c2.size) == CGSize(width: 1298, height: 1837)
                    }

                    it("has a C3 format") {
                        expect(PDFPageFormat.c3.size) == CGSize(width: 918, height: 1298)
                    }

                    it("has a C4 format") {
                        expect(PDFPageFormat.c4.size) == CGSize(width: 649, height: 918)
                    }

                    it("has a C5 format") {
                        expect(PDFPageFormat.c5.size) == CGSize(width: 459, height: 649)
                    }

                    it("has a C6 format") {
                        expect(PDFPageFormat.c6.size) == CGSize(width: 323, height: 459)
                    }

                    it("has a C7 format") {
                        expect(PDFPageFormat.c7.size) == CGSize(width: 230, height: 323)
                    }

                    it("has a C8 format") {
                        expect(PDFPageFormat.c8.size) == CGSize(width: 162, height: 230)
                    }

                    it("has a C9 format") {
                        expect(PDFPageFormat.c9.size) == CGSize(width: 113, height: 162)
                    }

                    it("has a C10 format") {
                        expect(PDFPageFormat.c10.size) == CGSize(width: 79, height: 113)
                    }
                }
            }
        }
    }

}
