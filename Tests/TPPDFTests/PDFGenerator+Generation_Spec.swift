//
//  PDFGenerator+Generation_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics
import Quick
import Nimble
@testable import TPPDF

class PDFGenerator_Generation_Spec: QuickSpec {

    override func spec() {
        describe("PDFGenerator") {

            context("Generation") {

                let document = PDFDocument(format: .a4)

                context("URL") {
                    it("should generate and write to URL with PDF suffix") {
                        let filename = "FILENAME"

                        var url: URL!
                        expect {
                            url = try PDFGenerator(document: document).generateURL(filename: filename)
                            return nil
                            }.toNot(throwError())
                        expect(url).toEventuallyNot(beNil())

                        var writtenData: Data!
                        expect {
                            writtenData = try Data(contentsOf: url)
                            }.toNot(throwError())
                        expect(writtenData).toEventuallyNot(beNil())

                        //                        let expectedBase64 = ""
                        // TODO: implement correct base64
                        //                    expect(writtenData.base64EncodedString()).toEventually(equal(expectedBase64))
                    }

                    it("should generate and write to URL without PDF suffix") {
                        let filename = "FILENAME.pdf"

                        var url: URL!
                        expect {
                            url = try PDFGenerator(document: document).generateURL(filename: filename)
                            return nil
                            }.toNot(throwError())
                        expect(url).toEventuallyNot(beNil())

                        var writtenData: Data!
                        expect {
                            writtenData = try Data(contentsOf: url)
                            }.toNot(throwError())
                        expect(writtenData).toEventuallyNot(beNil())

                        //                        let expectedBase64 = ""
                        // TODO: implement correct base64
                        //                    expect(writtenData.base64EncodedString()).toEventually(equal(expectedBase64))
                    }

                    it("should generate with debug and write to URL") {
                        let filename = "FILENAME"

                        var url: URL!
                        expect {
                            url = try PDFGenerator(document: document).generateURL(filename: filename)
                            return nil
                            }.toNot(throwError())
                        expect(url).toEventuallyNot(beNil())

                        var writtenData: Data!
                        expect {
                            writtenData = try Data(contentsOf: url)
                            }.toNot(throwError())
                        expect(writtenData).toEventuallyNot(beNil())

                        //                        let expectedBase64 = ""
                        // TODO: implement correct base64
                        //                    expect(writtenData.base64EncodedString()).toEventually(equal(expectedBase64))
                    }
                }

                describe("data") {

                    it("should generate") {
                        //                        let filename = "FILENAME"

                        var data: Data!
                        expect {
                            data = try PDFGenerator(document: document).generateData()
                            return nil
                            }.toNot(throwError())
                        expect(data).toEventuallyNot(beNil())
                        //                        let expectedBase64 = ""
                        // TODO: implement correct base64
                        // expect(data()).toEventually(equal(expectedBase64))
                    }

                    it("should generate with debug") {
                        //                        let filename = "FILENAME"

                        var data: Data!
                        expect {
                            data = try PDFGenerator(document: document).generateData()
                            return nil
                            }.toNot(throwError())
                        expect(data).toEventuallyNot(beNil())
                        //                        let expectedBase64 = ""
                        // TODO: implement correct base64
                        // expect(data()).toEventually(equal(expectedBase64))
                    }
                }

                it("should generate pdf context") {
                    // TODO: test PDFGenerator.generatePDFContext
                }

                it("should create render objects") {
                    // TODO: test PDFGenerator.createRenderObjects
                }

                it("should add header footer objects") {
                    // TODO: test PDFGenerator.addHeaderFooterObjects
                }

                it("should render objects") {
                    // TODO: test PDFGenerator.render(objects:)
                }

                it("should render object") {
                    class CustomObject: PDFRenderObject {

                        static var called = false

                        override func draw(generator: PDFGenerator, container: PDFContainer, in context: CGContext) throws {
                            CustomObject.called = true
                        }

                    }

                    let obj = CustomObject()

                    let document = PDFDocument(format: .a4)
                    let generator = PDFGenerator(document: document)
                    let context = PDFContextGraphics.createBitmapContext(size: .init(width: 100, height: 100))!

                    expect(CustomObject.called).to(beFalse())

                    try? generator.render(object: obj, in: .headerLeft, in: context)

                    expect(CustomObject.called).to(beTrue())
                }

                context("extract") {

                    let objs: [PDFLocatedRenderObject] = [
                        (PDFContainer.headerLeft, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerLeft, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerLeft, PDFSpaceObject(space: 10)),

                        (PDFContainer.headerCenter, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerCenter, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerCenter, PDFSpaceObject(space: 10)),

                        (PDFContainer.headerRight, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerRight, PDFSpaceObject(space: 10)),
                        (PDFContainer.headerRight, PDFSpaceObject(space: 10)),

                        (PDFContainer.contentLeft, PDFSpaceObject(space: 10)),
                        (PDFContainer.contentLeft, PDFSpaceObject(space: 10)),

                        (PDFContainer.contentCenter, PDFSpaceObject(space: 10)),
                        (PDFContainer.contentCenter, PDFSpaceObject(space: 10)),

                        (PDFContainer.contentRight, PDFSpaceObject(space: 10)),
                        (PDFContainer.contentRight, PDFSpaceObject(space: 10)),

                        (PDFContainer.footerLeft, PDFSpaceObject(space: 10)),
                        (PDFContainer.footerCenter, PDFSpaceObject(space: 10)),
                        (PDFContainer.footerRight, PDFSpaceObject(space: 10))
                    ]
                    let headerObjs = objs[0...8]
                    let contentObjs = objs[9...14]
                    let footerObjs = objs[15...17]

                    it("can extract header objects") {
                        let resultObjs = PDFGenerator.extractHeaderObjects(objects: objs)

                        expect(resultObjs.count) == headerObjs.count
                    }

                    it("can extract footer objects") {
                        let resultObjs = PDFGenerator.extractFooterObjects(objects: objs)

                        expect(resultObjs.count) == footerObjs.count
                    }

                    it("can extract content objects") {
                        let resultObjs = PDFGenerator.extractContentObjects(objects: objs)

                        expect(resultObjs.count) == contentObjs.count
                    }

                    it("can extract content objects") {
                        let resultObjs = PDFGenerator.extractContentObjects(objects: objs)

                        expect(resultObjs.count) == contentObjs.count
                    }
                }

                describe("table of content") {

                    let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1", font: Font.systemFont(ofSize: 25), color: Color.green))
                    let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2", font: Font.systemFont(ofSize: 20), color: Color.red))
                    let headingStyle3 = document.add(style: PDFTextStyle(name: "Heading 3", font: Font.systemFont(ofSize: 18), color: Color.blue))
                    let bodyStyle = document.add(style: PDFTextStyle(name: "Body", font: Font.systemFont(ofSize: 12), color: Color.orange))

                    let styles = [
                        headingStyle1,
                        headingStyle2,
                        headingStyle3
                        ].map(WeakPDFTextStyleRef.init(value:))

                    let textObjects = [
                        PDFSimpleText(text: "Heading 1", style: headingStyle1),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 1.1", style: headingStyle2),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 2", style: headingStyle1),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 2.1", style: headingStyle2),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 2.1.1", style: headingStyle3),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 3", style: headingStyle1),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle),

                        PDFSimpleText(text: "Heading 3.1.1", style: headingStyle3),
                        PDFSimpleText(text: "Body", style: bodyStyle),
                        PDFSimpleText(text: "Body", style: bodyStyle)
                    ]
                    let objs: [PDFLocatedRenderObject] = textObjects.map { return (PDFContainer.contentLeft, PDFAttributedTextObject(simpleText: $0)) }

                    it("should create list based on styles") {
                        let list = PDFGenerator.createTableOfContentList(objects: objs, styles: styles, symbol: .dot)
                        let expectedList = PDFList(indentations: [
                            (pre: CGFloat(10), past: CGFloat(10)),
                            (pre: CGFloat(20), past: CGFloat(10)),
                            (pre: CGFloat(30), past: CGFloat(10))
                        ])
                        expectedList.addItems([
                            PDFListItem(symbol: .dot, content: textObjects[0].text)
                                .addItem(PDFListItem(symbol: .dot, content: textObjects[3].text)),
                            PDFListItem(symbol: .dot, content: textObjects[6].text)
                                .addItem(PDFListItem(symbol: .dot, content: textObjects[9].text)
                                    .addItem(PDFListItem(symbol: .dot, content: textObjects[12].text))),
                            PDFListItem(symbol: .dot, content: textObjects[15].text)
                                .addItem(PDFListItem(symbol: .none, content: nil)
                                    .addItem(PDFListItem(symbol: .dot, content: textObjects[18].text))),
                            ])

                        expect(list).to(equal(expectedList))
                    }
                }
            }
        }
    }
}
