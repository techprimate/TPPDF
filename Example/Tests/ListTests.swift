//
//  ListTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

import Quick
import Nimble
@testable import TPPDF

class ListSpec: QuickSpec {
    override func spec() {
        describe("the List") {
            let list = List(indentations: [(pre: 0.0, past: 10.0), (pre: 10.0, past: 10.0), (pre: 20.0, past: 10.0)])
            it("has no items by default") {
                expect(list.count).to(equal(0))
            }
            
            it("should have different level indentations") {
                expect(list.levelIndentations[0].pre).to(equal(0.0))
                expect(list.levelIndentations[0].past).to(equal(10.0))
                expect(list.levelIndentations[1].pre).to(equal(10.0))
                expect(list.levelIndentations[1].past).to(equal(10.0))
                expect(list.levelIndentations[2].pre).to(equal(20.0))
                expect(list.levelIndentations[2].past).to(equal(10.0))
            }
            
            it("should have one item") {
                list.addItem(ListItem(symbol: .dash, content: "Item 1"))
                
                expect(list.count).to(equal(1))
                expect(list.items[0].content).to(equal("Item 1"))
                expect(list.items[0].symbol.rawValue).to(equal(ListItem.Symbol.dash.rawValue))
            }
            
            it("should flatten to four items") {
                list.clear()
                
                list.addItems(
                    [
                        ListItem(symbol: .dot, content: "Base 1")
                            .addItems(
                                [
                                    ListItem(symbol: .numbered(value: nil))
                                        .addItems(
                                            [
                                                ListItem(content: "Child 2.1"),
                                                ListItem(symbol: .none, content: "Child 2.2"),
                                                ListItem(content: "Child 2.3"),
                                            ]
                                    )
                                ]
                        ),
                        ListItem(symbol: .dash, content: "Base 2")
                            .addItems(
                                [
                                    ListItem(content: "Child 2.1")
                                        .addItems(
                                            [
                                                ListItem(symbol: .dot, content: "Child 2.1.1")
                                            ]),
                                    ListItem(content: "Child 2.2")
                                        .addItems(
                                            [
                                                ListItem(symbol: .dash, content: "Child 2.2.1")
                                            ]
                                    )
                                ]
                        )
                    ]
                )
                
                let flattedList = list.flatted()
                expect(flattedList.count).to(equal(9))
                
                expect(flattedList[0].level).to(equal(0))
                expect(flattedList[0].text).to(equal("Base 1"))
                expect(flattedList[0].symbol.rawValue).to(equal(ListItem.Symbol.dot.rawValue))
                
                expect(flattedList[1].level).to(equal(1))
                expect(flattedList[1].text).to(equal("Child 2.1"))
                expect(flattedList[1].symbol.rawValue).to(equal(ListItem.Symbol.numbered(value: "1").rawValue))
                
                expect(flattedList[2].level).to(equal(1))
                expect(flattedList[2].text).to(equal("Child 2.2"))
                expect(flattedList[2].symbol.rawValue).to(equal(ListItem.Symbol.none.rawValue))
                
                expect(flattedList[3].level).to(equal(1))
                expect(flattedList[3].text).to(equal("Child 2.3"))
                expect(flattedList[3].symbol.rawValue).to(equal(ListItem.Symbol.numbered(value: "3").rawValue))
                
                expect(flattedList[4].level).to(equal(0))
                expect(flattedList[4].text).to(equal("Base 2"))
                expect(flattedList[4].symbol.rawValue).to(equal(ListItem.Symbol.dash.rawValue))
                
                expect(flattedList[5].level).to(equal(1))
                expect(flattedList[5].text).to(equal("Child 2.1"))
                expect(flattedList[5].symbol.rawValue).to(equal(ListItem.Symbol.dash.rawValue))
                
                expect(flattedList[6].level).to(equal(2))
                expect(flattedList[6].text).to(equal("Child 2.1.1"))
                expect(flattedList[6].symbol.rawValue).to(equal(ListItem.Symbol.dot.rawValue))
                
                expect(flattedList[7].level).to(equal(1))
                expect(flattedList[7].text).to(equal("Child 2.2"))
                expect(flattedList[7].symbol.rawValue).to(equal(ListItem.Symbol.dash.rawValue))
                
                expect(flattedList[8].level).to(equal(2))
                expect(flattedList[8].text).to(equal("Child 2.2.1"))
                expect(flattedList[8].symbol.rawValue).to(equal(ListItem.Symbol.dash.rawValue))
            }
        }
    }
}
