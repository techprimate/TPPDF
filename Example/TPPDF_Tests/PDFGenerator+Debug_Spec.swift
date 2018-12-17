//
//  PDFGenerator+Debug_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 23.11.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFGenerator_Debug_Spec: QuickSpec {

    override func spec() {
        describe("PDFGenerator") {

            context("Debug") {

                let document = PDFDocument(layout: PDFPageLayout(size: CGSize(width: 50, height: 50),
                                                                 margin: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                                                 space: (header: 5, footer: 5)))
                let generator = PDFGenerator(document: document)

                it("should not draw overlay if debug is disabled") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = false
                    generator.drawDebugPageOverlay()

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    for x in 0..<Int(image!.size.width) {
                        for y in 0..<Int(image!.size.height) {
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                let expected = UIColor.clear.hex
                                let result = pixel.hex
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

                it("should draw margin lines") {
                    UIGraphicsBeginImageContext(document.layout.size)

                    generator.debug = true
                    generator.drawDebugPageOverlay()

                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()

                    let extractor = image?.pixelExtractor

                    expect(image).toNot(beNil())
                    for x in 0..<Int(image!.size.width) {
                        for y in 0..<Int(image!.size.height) {
                            if let pixel = extractor?.colorAt(x: x, y: y) {
                                var expected = UIColor.clear
                                let result = pixel

                                if CGFloat(x) == document.layout.margin.left ||
                                    CGFloat(x) == document.layout.width - document.layout.margin.right ||
                                    CGFloat(y) == document.layout.margin.top ||
                                    CGFloat(y) == document.layout.margin.top + document.layout.space.header ||
                                    CGFloat(y) == document.layout.height - document.layout.margin.bottom ||
                                    CGFloat(y) == document.layout.height - document.layout.margin.bottom - document.layout.space.footer {
                                    expected = UIColor.blue
                                }

//                                expect(result.isClose(to: expected, decimals: 2))
//                                    .to(beTrue(),
//                                        description: "Pixel at <\(x), \(y)> is expected to equal <\(expected)>, got <\(result)>")

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
