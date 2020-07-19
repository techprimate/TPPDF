//
//  PDFListItemObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 06.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
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
                    var result: [PDFLocatedRenderObject]?

                    expect {
                        result = try? object.calculate(generator: generator, container: container)
                    }.toNot(throwError())

                    expect(result).toNot(beNil())
                    expect(result?.count).to(equal(13))

                    expect(result?[0].0).to(equal(PDFContainer.contentLeft))

                    var item: PDFAttributedTextObject? = result?[0].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 10))
                    expect(item?.frame.origin.y).to(equal(75))
                    expect(item?.frame.size.width).to(beCloseTo(10, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "1.")))

                    expect(result?[1].0).to(equal(PDFContainer.contentLeft))

                    item = result?[1].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(75))
                    expect(item?.frame.size.width).to(beCloseTo(60, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Heading 1")))

                    expect(result?[2].0).to(equal(PDFContainer.contentLeft))

                    item = result?[2].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 10))
                    expect(item?.frame.origin.y).to(equal(91))
                    expect(item?.frame.size.width).to(beCloseTo(10, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "?.")))

                    expect(result?[3].0).to(equal(PDFContainer.contentLeft))

                    item = result?[3].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(91))
                    expect(item?.frame.size.width).to(beCloseTo(62, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Heading 2")))

                    expect(result?[4].0).to(equal(PDFContainer.contentLeft))

                    item = result?[4].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 10))
                    expect(item?.frame.origin.y).to(equal(107))
                    expect(item?.frame.size.width).to(beCloseTo(4, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: PDFListItemSymbol.dot.stringValue)))

                    expect(result?[5].0).to(equal(PDFContainer.contentLeft))

                    item = result?[5].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(107))
                    expect(item?.frame.size.width).to(beCloseTo(62, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Heading 3")))

                    expect(result?[6].0).to(equal(PDFContainer.contentLeft))

                    item = result?[6].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(123))
                    expect(item?.frame.size.width).to(beCloseTo(6, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: PDFListItemSymbol.dash.stringValue)))

                    expect(result?[7].0).to(equal(PDFContainer.contentLeft))

                    item = result?[7].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 30))
                    expect(item?.frame.origin.y).to(equal(123))
                    expect(item?.frame.size.width).to(beCloseTo(82, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Subheading 1")))

                    expect(result?[8].0).to(equal(PDFContainer.contentLeft))

                    item = result?[8].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 30))
                    expect(item?.frame.origin.y).to(equal(139))
                    expect(item?.frame.size.width).to(beCloseTo(84, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Subheading 2")))

                    expect(result?[9].0).to(equal(PDFContainer.contentLeft))

                    item = result?[9].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(155))
                    expect(item?.frame.size.width).to(beCloseTo(4, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: PDFListItemSymbol.dot.stringValue)))

                    expect(result?[10].0).to(equal(PDFContainer.contentLeft))

                    item = result?[10].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 30))
                    expect(item?.frame.origin.y).to(equal(155))
                    expect(item?.frame.size.width).to(beCloseTo(84, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Subheading 3")))

                    expect(result?[11].0).to(equal(PDFContainer.contentLeft))

                    item = result?[11].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 10))
                    expect(item?.frame.origin.y).to(equal(171))
                    expect(item?.frame.size.width).to(beCloseTo(8, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "+")))

                    expect(result?[12].0).to(equal(PDFContainer.contentLeft))

                    item = result?[12].1 as? PDFAttributedTextObject
                    expect(item?.frame.origin.x).to(equal(document.layout.margin.left + 20))
                    expect(item?.frame.origin.y).to(equal(171))
                    expect(item?.frame.size.width).to(beCloseTo(62, within: 1))
                    expect(item?.frame.size.height).to(equal(16.0))
                    expect(item?.simpleText).to(equal(PDFSimpleText(text: "Heading 4")))
                }

                it("should use zero indentation") {
                    object.list.levelIndentations = []
                    var result: [PDFLocatedRenderObject]?

                    expect {
                        result = try? object.calculate(generator: generator, container: container)
                        }.toNot(throwError())

                    expect(result).toNot(beNil())
                    expect(result?.count).to(equal(13))

                    expect(result?[0].0).to(equal(PDFContainer.contentLeft))

                    guard let item = result?[0].1 as? PDFAttributedTextObject else {
                        fail()
                        return
                    }
                    expect(item.frame.origin.x) == document.layout.margin.left
                    expect(item.frame.origin.y) == 75
                    expect(item.frame.size.width).to(beCloseTo(10, within: 1))
                    expect(item.frame.size.height) == 16
                    expect(item.simpleText) == PDFSimpleText(text: "1.")

                    expect(result?[1].0).to(equal(PDFContainer.contentLeft))

                    guard let otherItem = result?[1].1 as? PDFAttributedTextObject else {
                        fail()
                        return
                    }
                    expect(otherItem.frame.origin.x) == document.layout.margin.left
                    expect(otherItem.frame.origin.y) == 75
                    expect(otherItem.frame.size.width).to(beCloseTo(59, within: 1))
                    expect(otherItem.frame.size.height) == 16
                    expect(otherItem.simpleText) == PDFSimpleText(text: "Heading 1")

                    expect(result?[2].0).to(equal(PDFContainer.contentLeft))
                }
            }
        }
    }

}
