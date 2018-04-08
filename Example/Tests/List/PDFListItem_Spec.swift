//
//  PDFListItem_Spec.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFListItem_Spec: QuickSpec {

    override func spec() {
        describe("PDFListItem") {

            var object: PDFListItem!

            beforeEach {
                object = PDFListItem()
            }

            describe("variables") {

                it("has an optional parent") {
                    expect(object.parent).to(beNil())
                }

                it("has a optional content") {
                    expect(object.content).to(beNil())
                }

                it("has a optional children") {
                    expect(object.children).to(beNil())
                }

                it("has a symbol with default value") {
                    expect(object.symbol.rawValue) == PDFListItemSymbol.inherit.rawValue
                }
            }

            describe("initializer") {

                it("can be initalized with a symbol") {
                    object = PDFListItem(symbol: .dash)
                    expect(object.symbol.rawValue) == PDFListItemSymbol.dash.rawValue
                }

                it("can be initalized with a content") {
                    let content = "EXAMPLE"

                    object = PDFListItem(content: content)
                    expect(object.content) == content
                }
            }

            context("children") {

                it("can add multiple items") {
                    let items = [
                        PDFListItem(symbol: .dash, content: "A1"),
                        PDFListItem(symbol: .dot, content: "A2")
                    ]

                    expect(object.addItems(items)) === object

                    expect(object.children?[0].parent) === object
                    expect(object.children?[0].content) == items[0].content
                    expect(object.children?[0].symbol.rawValue) == items[0].symbol.rawValue

                    expect(object.children?[1].parent) === object
                    expect(object.children?[1].content) == items[1].content
                    expect(object.children?[1].symbol.rawValue) == items[1].symbol.rawValue
                }

                it("can add an item") {
                    let item = PDFListItem(symbol: .dash, content: "A1")

                    expect(object.addItem(item)) === object

                    expect(object.children?[0].parent) === object
                    expect(object.children?[0].content) == item.content
                    expect(object.children?[0].symbol.rawValue) == item.symbol.rawValue
                }
            }

            it("can set the content") {
                let content = "RANDOMNEWCONTENT"
                expect(object.setContent(content)) === object
                expect(object.content) == content
            }

            context("JSON") {

                it("can be represented") {
                    let content = "RANDOMNEWCONTENT"
                    object.content = content
                    object.symbol = PDFListItemSymbol.dot

                    let item = PDFListItem(symbol: .dash, content: "A1")

                    let representation = object.addItem(item).JSONRepresentation as? [String: AnyObject]
                    expect(representation).toNot(beNil())

                    expect(representation?["content"] as? String) == content
                    expect(representation?["symbol"] as? String) == PDFListItemSymbol.dot.JSONRepresentation as? String

                    let children = representation?["children"] as? [[String: AnyObject]]
                    expect(children).toNot(beNil())
                    expect(children?.count) == 1
                    expect(children?[0].JSONRepresentation as? [String: String]) == item.JSONRepresentation as? [String: String]
                }
            }
        }
    }

}
