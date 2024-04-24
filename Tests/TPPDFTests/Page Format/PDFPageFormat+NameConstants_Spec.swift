import CoreGraphics
import Nimble
import Quick
@testable import TPPDF

class PDFPageFormat_NameConstants_Spec: QuickSpec {
    override func spec() {
        describe("PDFPagename") {
            context("NameConstants") {
                context("US Series") {
                    it("has a US Half Letter name") {
                        expect(PDFPageFormat.usHalfLetter.name) == "US Half Letter"
                    }

                    it("has a US Letter name") {
                        expect(PDFPageFormat.usLetter.name) == "US Letter"
                    }

                    it("has a US Legal name") {
                        expect(PDFPageFormat.usLegal.name) == "US Legal"
                    }

                    it("has a US Junior Legal name") {
                        expect(PDFPageFormat.usJuniorLegal.name) == "US Junior Legal"
                    }

                    it("has a US Ledger name") {
                        expect(PDFPageFormat.usLedger.name) == "US Ledger"
                    }
                }

                context("ANSI Series") {
                    it("has a ANSI A name") {
                        expect(PDFPageFormat.ansiA.name) == "ANSI A"
                    }

                    it("has a ANSI B name") {
                        expect(PDFPageFormat.ansiB.name) == "ANSI B"
                    }

                    it("has a ANSI C name") {
                        expect(PDFPageFormat.ansiC.name) == "ANSI C"
                    }

                    it("has a ANSI D name") {
                        expect(PDFPageFormat.ansiD.name) == "ANSI D"
                    }

                    it("has a ANSI E name") {
                        expect(PDFPageFormat.ansiE.name) == "ANSI E"
                    }
                }

                context("A Series") {
                    it("has a A0 name") {
                        expect(PDFPageFormat.a0.name) == "A0"
                    }

                    it("has a A1 name") {
                        expect(PDFPageFormat.a1.name) == "A1"
                    }

                    it("has a A2 name") {
                        expect(PDFPageFormat.a2.name) == "A2"
                    }

                    it("has a A3 name") {
                        expect(PDFPageFormat.a3.name) == "A3"
                    }

                    it("has a A4 name") {
                        expect(PDFPageFormat.a4.name) == "A4"
                    }

                    it("has a A5 name") {
                        expect(PDFPageFormat.a5.name) == "A5"
                    }

                    it("has a A6 name") {
                        expect(PDFPageFormat.a6.name) == "A6"
                    }

                    it("has a A7 name") {
                        expect(PDFPageFormat.a7.name) == "A7"
                    }

                    it("has a A8 name") {
                        expect(PDFPageFormat.a8.name) == "A8"
                    }

                    it("has a A9 name") {
                        expect(PDFPageFormat.a9.name) == "A9"
                    }

                    it("has a A10 name") {
                        expect(PDFPageFormat.a10.name) == "A10"
                    }
                }

                context("B Series") {
                    it("has a B0 name") {
                        expect(PDFPageFormat.b0.name) == "B0"
                    }

                    it("has a B1 name") {
                        expect(PDFPageFormat.b1.name) == "B1"
                    }

                    it("has a B2 name") {
                        expect(PDFPageFormat.b2.name) == "B2"
                    }

                    it("has a B3 name") {
                        expect(PDFPageFormat.b3.name) == "B3"
                    }

                    it("has a B4 name") {
                        expect(PDFPageFormat.b4.name) == "B4"
                    }

                    it("has a B5 name") {
                        expect(PDFPageFormat.b5.name) == "B5"
                    }

                    it("has a B6 name") {
                        expect(PDFPageFormat.b6.name) == "B6"
                    }

                    it("has a B7 name") {
                        expect(PDFPageFormat.b7.name) == "B7"
                    }

                    it("has a B8 name") {
                        expect(PDFPageFormat.b8.name) == "B8"
                    }

                    it("has a B9 name") {
                        expect(PDFPageFormat.b9.name) == "B9"
                    }

                    it("has a B10 name") {
                        expect(PDFPageFormat.b10.name) == "B10"
                    }
                }

                context("C Series") {
                    it("has a C0 name") {
                        expect(PDFPageFormat.c0.name) == "C0"
                    }

                    it("has a C1 name") {
                        expect(PDFPageFormat.c1.name) == "C1"
                    }

                    it("has a C2 name") {
                        expect(PDFPageFormat.c2.name) == "C2"
                    }

                    it("has a C3 name") {
                        expect(PDFPageFormat.c3.name) == "C3"
                    }

                    it("has a C4 name") {
                        expect(PDFPageFormat.c4.name) == "C4"
                    }

                    it("has a C5 name") {
                        expect(PDFPageFormat.c5.name) == "C5"
                    }

                    it("has a C6 name") {
                        expect(PDFPageFormat.c6.name) == "C6"
                    }

                    it("has a C7 name") {
                        expect(PDFPageFormat.c7.name) == "C7"
                    }

                    it("has a C8 name") {
                        expect(PDFPageFormat.c8.name) == "C8"
                    }

                    it("has a C9 name") {
                        expect(PDFPageFormat.c9.name) == "C9"
                    }

                    it("has a C10 name") {
                        expect(PDFPageFormat.c10.name) == "C10"
                    }
                }
            }
        }
    }
}
