//
//  PDFGenerator+Generation_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 27.12.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

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
                            url = try PDFGenerator.generateURL(document: document, filename: filename, debug: false)
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
                            url = try PDFGenerator.generateURL(document: document, filename: filename, debug: false)
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
                            url = try PDFGenerator.generateURL(document: document, filename: filename, debug: true)
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
                            data = try PDFGenerator.generateData(document: document, debug: false)
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
                            data = try PDFGenerator.generateData(document: document, debug: true)
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
                    class CustomObject: PDFObject {

                        static var called = false

                        override func draw(generator: PDFGenerator, container: PDFContainer) throws {
                            CustomObject.called = true
                        }

                    }

                    let obj = CustomObject()

                    let document = PDFDocument(format: .a4)
                    let generator = PDFGenerator(document: document)

                    expect(CustomObject.called).to(beFalse())

                    try? generator.render(object: obj, in: .headerLeft)

                    expect(CustomObject.called).to(beTrue())
                }

                context("extract") {

                    let objs: [(PDFContainer, PDFObject)] = [
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
                }
            }
        }
    }

}
