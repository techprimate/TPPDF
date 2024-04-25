//
//  PDFSpaceObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 14/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
import Nimble
import Quick
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
                var result: [PDFLocatedRenderObject]!

                beforeEach {
                    generator = PDFGenerator(document: document)
                    result = []
                }

                it("can set space") {
                    let contentHeight = generator.layout.heights.content

                    expect {
                        result = try object.calculate(generator: generator, container: container)
                    }.toNot(throwError())
                    expect(generator.layout.heights.content).toEventually(equal(contentHeight + object.frame.height))

                    expect(object.frame) == CGRect(x: 60, y: 60, width: 475, height: space)

                    expect(result).toEventually(haveCount(1))
                    expect(result.first?.0).toEventually(equal(container))
                    expect(result.first?.1 as? PDFSpaceObject).toEventually(be(object))
                }
            }

            context("rendering") {
                let document = PDFDocument(layout: PDFPageLayout(size: CGSize(width: 60, height: 60),
                                                                 margin: EdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                                 space: (header: 5, footer: 5)))
                let generator = PDFGenerator(document: document)

                let container = PDFContainer.contentLeft

                it("should not draw frame if debug is disabled") {
//                    UIGraphicsBeginImageContext(document.layout.size)
//                    guard let context = UIGraphicsGetCurrentContext() else {
//                        fatalError()
//                    }
//                    generator.debug = false
//
//                    expect {
//                        let _ = try object.calculate(generator: generator, container: container)
//                        try object.draw(generator: generator, container: container, in: context)
//
//                        return nil
//                        }.toNot(throwError())
//
//                    let image = UIGraphicsGetImageFromCurrentImageContext()
//                    UIGraphicsEndImageContext()
//
//                    let extractor = image?.pixelExtractor
//
//                    expect(image).toNot(beNil())
//                    var shouldExit = false
//
//                    for x in 0..<Int(image!.size.width) {
//                        if shouldExit {
//                            break
//                        }
//                        for y in 0..<Int(image!.size.height) {
//                            if shouldExit {
//                                break
//                            }
//                            if let pixel = extractor?.colorAt(x: x, y: y) {
//                                let expected = Color.clear.hex
//                                let result = pixel.hex
//                                // TODO: add pixel testing
//                                // expect(result).toEventually(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")
//
//                                // Early exit to only fail at first error!
//                                if result != expected {
//                                    shouldExit = true
//                                }
//                            }
//                        }
//                    }
                }

                it("should draw frame if debug is enabled") {
//                    UIGraphicsBeginImageContext(document.layout.size)
//                    guard let context = UIGraphicsGetCurrentContext() else {
//                        fail("Could not get graphics context")
//                        return
//                    }
//
//                    generator.debug = true
//
//                    expect {
//                        let _ = try object.calculate(generator: generator, container: container)
//                        try object.draw(generator: generator, container: container, in: context)
//
//                        return nil
//                        }.toNot(throwError())
//
//                    let image = UIGraphicsGetImageFromCurrentImageContext()
//                    UIGraphicsEndImageContext()
//
//                    let extractor = image?.pixelExtractor
//
//                    expect(image).toNot(beNil())
//                    var shouldExit = false
//
//                    for x in 0..<Int(image!.size.width) {
//                        if shouldExit {
//                            break
//                        }
//                        for y in 0..<Int(image!.size.height) {
//                            if shouldExit {
//                                break
//                            }
//                            if let pixel = extractor?.colorAt(x: x, y: y) {
//                                var expected = Color.clear.hex
//                                let result = pixel.hex
//
//                                if object.frame.contains(CGPoint(x: x, y: y)) {
//                                    if CGFloat(x) == object.frame.minX || CGFloat(x) == object.frame.maxX || CGFloat(y) == object.frame.minY || CGFloat(y) == object.frame.maxY {
//                                        expected = Color.red.hex
//                                    } else {
//                                        expected = Color.green.hex
//                                    }
//                                }
//
//                                // TODO: add pixel testing
//                                // expect(result).toEventually(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")
//
//                                // Early exit to only fail at first error!
//                                if result != expected {
//                                    shouldExit = true
//                                }
//                            }
//                        }
//                    }
                }
            }
        }
    }
}
