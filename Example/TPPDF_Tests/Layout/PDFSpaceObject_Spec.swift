//
//  PDFSpaceObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFSpaceObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFSpaceObject") {

            var object: PDFSpaceObject!
            let space: CGFloat = 20.0

            beforeEach {
                object = PDFSpaceObject(space: space)
            }

            describe("variables") {

                it("has an space value") {
                    expect(object.space) == space
                }
            }

            context("calculation") {

                let document = PDFDocument(format: .a4)
                var generator: PDFGenerator!

                let container = PDFContainer.contentLeft
                var result: [(PDFContainer, PDFObject)]!

                beforeEach {
                    generator = PDFGenerator(document: document)
                    result = []
                }

                it("can set space") {
                    let x = document.layout.margin.left
                        + generator.layout.indentation.leftIn(container: container)

                    let y = document.layout.margin.bottom
                        + generator.layout.heights.maxHeaderHeight()
                        + document.layout.space.header
                        + generator.layout.heights.content

                    let width = document.layout.size.width
                        - document.layout.margin.left
                        - generator.layout.indentation.leftIn(container: container)
                        - generator.layout.indentation.rightIn(container: container)
                        - document.layout.margin.right

                    let contentHeight = generator.layout.heights.content

                    expect {
                        result = try object.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    expect(generator.layout.heights.content).toEventually(equal(contentHeight + object.frame.height))

                    expect(object.frame) == CGRect(x: x, y: y, width: width, height: space)

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFSpaceObject).toEventually(be(object))
                }
            }

            context("rendering") {

                let document = PDFDocument(layout: PDFPageLayout(size: CGSize(width: 60, height: 60),
                                                                 margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                                 space: (header: 5, footer: 5)))
                let generator = PDFGenerator(document: document)

                let container = PDFContainer.contentLeft

                it("should not draw frame if debug is disabled") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = false

                    expect {
                        let _ = try object.calculate(generator: generator, container: container)
                        try object.draw(generator: generator, container: container)

                        return nil
                        }.toNot(throwError())

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    var shouldExit = false

                    for x in 0..<Int(image!.size.width) {
                        if shouldExit {
                            break
                        }
                        for y in 0..<Int(image!.size.height) {
                            if shouldExit {
                                break
                            }
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                let expected = UIColor.clear.hex
                                let result = pixel.hex
                                // TODO: add pixel testing
                                // expect(result).toEventually(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")

                                // Early exit to only fail at first error!
                                if result != expected {
                                    shouldExit = true
                                }
                            }
                        }
                    }
                }

                it("should draw frame if debug is enabled") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = true

                    expect {
                        let _ = try object.calculate(generator: generator, container: container)
                        try object.draw(generator: generator, container: container)

                        return nil
                        }.toNot(throwError())

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    var shouldExit = false

                    for x in 0..<Int(image!.size.width) {
                        if shouldExit {
                            break
                        }
                        for y in 0..<Int(image!.size.height) {
                            if shouldExit {
                                break
                            }
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                var expected = UIColor.clear.hex
                                let result = pixel.hex

                                if object.frame.contains(CGPoint(x: x, y: y)) {
                                    if CGFloat(x) == object.frame.minX || CGFloat(x) == object.frame.maxX || CGFloat(y) == object.frame.minY || CGFloat(y) == object.frame.maxY {
                                        expected = UIColor.red.hex
                                    } else {
                                        expected = UIColor.green.hex
                                    }
                                }

                                // TODO: add pixel testing
                                // expect(result).toEventually(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")

                                // Early exit to only fail at first error!
                                if result != expected {
                                    shouldExit = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
