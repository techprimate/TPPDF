//
//  PDFLineSeparatorObject_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFLineSeparatorObject_Spec: QuickSpec {

    override func spec() {
        describe("PDFLineSeparatorObject") {

            var separator: PDFLineSeparatorObject! = PDFLineSeparatorObject()

            context("variables") {

                it("has a line style") {
                    expect(separator.style).toNot(beNil())
                }
            }

            context("initalizers") {

                it("can be initalized without") {
                    separator = PDFLineSeparatorObject()
                    expect(separator).toNot(beNil())
                }

                it("can be initalized with a line style") {
                    let style = PDFLineStyle(type: .dotted, color: .orange, width: 0.25)

                    separator = PDFLineSeparatorObject(style: style)

                    expect(separator.style) == style
                }
            }

            context("calculation") {
                let document = PDFDocument(format: .a4)
                let generator = PDFGenerator(document: document)
                var container = PDFContainer.headerLeft

                it("works for container headerLeft") {
                    container = PDFContainer.headerLeft

                    let result = try? separator.calculate(generator: generator, container: container)

                    expect(result?.first?.0) == container
                    expect(result?.first?.1 as? PDFLineSeparatorObject) === separator
                    expect(separator.frame) == CGRect(x: 60, y: 60, width: 475, height: separator.style.width)
                }
            }

            context("drawing") {

                let document = PDFDocument(layout: PDFPageLayout(size: CGSize(width: 50, height: 50),
                                                                 margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                                 space: (header: 5, footer: 5)))
                let generator = PDFGenerator(document: document)
                let container = PDFContainer.contentCenter

                it("should not draw overlay if debug is disabled") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = false
                    let _ = try? separator.calculate(generator: generator, container: container)
                    try? separator.draw(generator: generator, container: container)

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    for x in 0..<Int(image!.size.width) {
                        for y in 0..<Int(image!.size.height) {
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                var expected = UIColor.clear.hex
                                let result = pixel.hex

                                if separator.frame.contains(CGPoint(x: x, y: y)) {
                                    expected = separator.style.color.hex
                                }
                                // TODO: add pixel testing
//                                expect(result).to(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")

                                // Early exit to only fail at first error!
                                if result != expected {
                                    return
                                }
                            }
                        }
                    }
                }

                it("should draw overlay if debug is enabled") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = true
                    let _ = try? separator.calculate(generator: generator, container: container)
                    try? separator.draw(generator: generator, container: container)

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    for x in 0..<Int(image!.size.width) {
                        for y in 0..<Int(image!.size.height) {
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                var expected = UIColor.clear.hex
                                let result = pixel.hex

                                if separator.frame.contains(CGPoint(x: x, y: y)) {
                                    expected = separator.style.color.hex

                                    if CGFloat(x) == separator.frame.minX || CGFloat(x) == separator.frame.maxX || CGFloat(y) == separator.frame.minY || CGFloat(y) == separator.frame.maxY {
                                        expected = UIColor.green.hex
                                    }
                                }
                                // TODO: add pixel testing
                                // expect(result).to(equal(expected), description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")

                                // Early exit to only fail at first error!
                                if result != expected {
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
