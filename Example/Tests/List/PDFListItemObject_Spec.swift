//
//  PDFListItemObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 06.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFListItemObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFListObject") {

            let list = PDFList(indentations: [(pre: 10, past: 10), (pre: 20, past: 10)])
            list.addItem(PDFListItem(symbol: .numbered(value: "1"), content: "Heading 1"))
                .addItem(PDFListItem(symbol: .numbered(value: nil), content: "Heading 2"))
                .addItem(PDFListItem(symbol: .dot, content: "Heading 3")
                    .addItem(PDFListItem(symbol: .dash, content: "Subheading 1"))
                    .addItem(PDFListItem(symbol: .none, content: "Subheading 2"))
                    .addItem(PDFListItem(symbol: .inherit, content: "Subheading 3")))
                .addItem(PDFListItem(symbol: .custom(value: "+"), content: "Heading 4"))

            let object = PDFListObject(list: list)

            context("variables") {

                it("has a list") {
                    expect(object.list) == list
                }
            }

            context("calculations") {

                let document = PDFDocument(format: .a4)
                let container = PDFContainer.contentLeft
                var generator: PDFGenerator!

                beforeEach {
                    generator = PDFGenerator(document: document)
                }

                it("can be calculated") {
                    var result: [(PDFContainer, PDFObject)]?

                    expect {
                        result = try? object.calculate(generator: generator, container: container)
                    }.toNot(throwError())

                    expect(result).toEventuallyNot(beNil())
                    expect(result?.count).toEventually(equal(13))

                    expect(result?[0].0).toEventually(equal(PDFContainer.contentLeft))

                    var item: PDFAttributedTextObject? = result?[0].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 10, y: 75, width: 10.0419921875, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "1.")))

                    expect(result?[1].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[1].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 75, width: 63.984375, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Heading 1")))

                    expect(result?[2].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[2].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 10, y: 92, width: 11.033203125, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "?.")))

                    expect(result?[3].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[3].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 92, width: 65.912109375, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Heading 2")))

                    expect(result?[4].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[4].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 10, y: 109, width: 4.15625, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: PDFListItemSymbol.dot.stringValue)))

                    expect(result?[5].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[5].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 109, width: 66.2333984375, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Heading 3")))

                    expect(result?[6].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[6].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 126, width: 6.453125, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: PDFListItemSymbol.dash.stringValue)))

                    expect(result?[7].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[7].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 30, y: 126, width: 87.1513671875, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Subheading 1")))

                    expect(result?[8].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[8].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 30, y: 143, width: 89.0791015625, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Subheading 2")))

                    expect(result?[9].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[9].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 160, width: 4.15625, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: PDFListItemSymbol.dot.stringValue)))

                    expect(result?[10].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[10].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 30, y: 160, width: 89.400390625, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Subheading 3")))

                    expect(result?[11].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[11].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 10, y: 177, width: 8.927734375, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "+")))

                    expect(result?[12].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[12].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left + 20, y: 177, width: 66.4658203125, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Heading 4")))
                }

                it("should use zero indentation") {
                    object.list.levelIndentations = []
                    var result: [(PDFContainer, PDFObject)]?

                    expect {
                        result = try? object.calculate(generator: generator, container: container)
                        }.toNot(throwError())

                    expect(result).toEventuallyNot(beNil())
                    expect(result?.count).toEventually(equal(13))

                    expect(result?[0].0).toEventually(equal(PDFContainer.contentLeft))

                    var item: PDFAttributedTextObject? = result?[0].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left, y: 75, width: 10.0419921875, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "1.")))

                    expect(result?[1].0).toEventually(equal(PDFContainer.contentLeft))

                    item = result?[1].1 as? PDFAttributedTextObject
                    expect(item?.frame).toEventually(equal(CGRect(x: document.layout.margin.left, y: 75, width: 63.984375, height: 17.0)))
                    expect(item?.simpleText).toEventually(equal(PDFSimpleText(text: "Heading 1")))

                    expect(result?[2].0).toEventually(equal(PDFContainer.contentLeft))
                }
            }
        }
    }

}
