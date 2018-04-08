//
//  PDFLayoutIndentations_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLayoutIndentations_Spec: QuickSpec {

    override func spec() {
        describe("PDFLayoutHeights") {

            var indentations: PDFLayoutIndentations!

            beforeEach {
                indentations = PDFLayoutIndentations()
            }

            context("variables") {

                it("has default header values") {
                    expect(indentations.header.left) == 0
                    expect(indentations.header.right) == 0
                }

                it("has default content values") {
                    expect(indentations.footer.left) == 0
                    expect(indentations.footer.right) == 0
                }

                it("has a default footer values") {
                    expect(indentations.content.left) == 0
                    expect(indentations.content.right) == 0
                }
            }

            context("accessors") {

                beforeEach {
                    indentations.header = (10, 20)
                    indentations.content = (30, 40)
                    indentations.footer = (50, 60)
                }

                context("left") {

                    it("can get value of header containers") {
                        expect(indentations.leftIn(container: PDFContainer.headerLeft)) == 10
                        expect(indentations.leftIn(container: PDFContainer.headerCenter)) == 10
                        expect(indentations.leftIn(container: PDFContainer.headerRight)) == 10
                    }

                    it("can get value of content containers") {
                        expect(indentations.leftIn(container: PDFContainer.contentLeft)) == 30
                        expect(indentations.leftIn(container: PDFContainer.contentCenter)) == 30
                        expect(indentations.leftIn(container: PDFContainer.contentRight)) == 30
                    }

                    it("can get value of footer containers") {
                        expect(indentations.leftIn(container: PDFContainer.footerLeft)) == 50
                        expect(indentations.leftIn(container: PDFContainer.footerCenter)) == 50
                        expect(indentations.leftIn(container: PDFContainer.footerRight)) == 50
                    }
                }

                context("right") {

                    it("can get value of header containers") {
                        expect(indentations.rightIn(container: PDFContainer.headerLeft)) == 20
                        expect(indentations.rightIn(container: PDFContainer.headerCenter)) == 20
                        expect(indentations.rightIn(container: PDFContainer.headerRight)) == 20
                    }

                    it("can get value of content containers") {
                        expect(indentations.rightIn(container: PDFContainer.contentLeft)) == 40
                        expect(indentations.rightIn(container: PDFContainer.contentCenter)) == 40
                        expect(indentations.rightIn(container: PDFContainer.contentRight)) == 40
                    }

                    it("can get value of footer containers") {
                        expect(indentations.rightIn(container: PDFContainer.footerLeft)) == 60
                        expect(indentations.rightIn(container: PDFContainer.footerCenter)) == 60
                        expect(indentations.rightIn(container: PDFContainer.footerRight)) == 60
                    }
                }
            }

            context("modifiers") {

                context("left") {

                    it("can set a value to a header container") {
                        indentations.setLeft(indentation: 10, in: PDFContainer.headerLeft)
                        expect(indentations.leftIn(container: PDFContainer.headerLeft)) == 10

                        indentations.setLeft(indentation: 20, in: PDFContainer.headerCenter)
                        expect(indentations.leftIn(container: PDFContainer.headerCenter)) == 20

                        indentations.setLeft(indentation: 30, in: PDFContainer.headerRight)
                        expect(indentations.leftIn(container: PDFContainer.headerRight)) == 30
                    }

                    it("can set a value to a content container") {
                        indentations.setLeft(indentation: 10, in: PDFContainer.contentLeft)
                        expect(indentations.leftIn(container: PDFContainer.contentLeft)) == 10

                        indentations.setLeft(indentation: 20, in: PDFContainer.contentCenter)
                        expect(indentations.leftIn(container: PDFContainer.contentCenter)) == 20

                        indentations.setLeft(indentation: 30, in: PDFContainer.contentRight)
                        expect(indentations.leftIn(container: PDFContainer.contentRight)) == 30
                    }

                    it("can set a value to a footer container") {
                        indentations.setLeft(indentation: 10, in: PDFContainer.footerLeft)
                        expect(indentations.leftIn(container: PDFContainer.footerLeft)) == 10

                        indentations.setLeft(indentation: 20, in: PDFContainer.footerCenter)
                        expect(indentations.leftIn(container: PDFContainer.footerCenter)) == 20

                        indentations.setLeft(indentation: 30, in: PDFContainer.footerRight)
                        expect(indentations.leftIn(container: PDFContainer.footerRight)) == 30
                    }
                }

                context("right") {

                    it("can set a value to a header container") {
                        indentations.setRight(indentation: 10, in: PDFContainer.headerLeft)
                        expect(indentations.rightIn(container: PDFContainer.headerLeft)) == 10

                        indentations.setRight(indentation: 20, in: PDFContainer.headerCenter)
                        expect(indentations.rightIn(container: PDFContainer.headerCenter)) == 20

                        indentations.setRight(indentation: 30, in: PDFContainer.headerRight)
                        expect(indentations.rightIn(container: PDFContainer.headerRight)) == 30
                    }

                    it("can set a value to a content container") {
                        indentations.setRight(indentation: 10, in: PDFContainer.contentLeft)
                        expect(indentations.rightIn(container: PDFContainer.contentLeft)) == 10

                        indentations.setRight(indentation: 20, in: PDFContainer.contentCenter)
                        expect(indentations.rightIn(container: PDFContainer.contentCenter)) == 20

                        indentations.setRight(indentation: 30, in: PDFContainer.contentRight)
                        expect(indentations.rightIn(container: PDFContainer.contentRight)) == 30
                    }

                    it("can set a value to a footer container") {
                        indentations.setRight(indentation: 10, in: PDFContainer.footerLeft)
                        expect(indentations.rightIn(container: PDFContainer.footerLeft)) == 10

                        indentations.setRight(indentation: 20, in: PDFContainer.footerCenter)
                        expect(indentations.rightIn(container: PDFContainer.footerCenter)) == 20

                        indentations.setRight(indentation: 30, in: PDFContainer.footerRight)
                        expect(indentations.rightIn(container: PDFContainer.footerRight)) == 30
                    }
                }
            }
        }
    }

}
