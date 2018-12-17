//
//  PDFGraphics_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 02/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFGraphics_Spec : QuickSpec {

    override func spec() {

        describe("PDFGraphics") {

            it("can not create an none path") {
                let start = CGPoint.zero
                let end = CGPoint(x: 100, y: 100)
                let style = PDFLineStyle.none

                let dashes = PDFGraphics.createLinePath(start: start, end: end, style: style)
                expect(dashes).to(beNil())
            }

            it("can create dashes with butts") {
                let width: CGFloat = 5
                let style = PDFLineStyle(type: .dashed, color: .red, width: width)

                var path = UIBezierPath()
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: 0, y: 100))

                let dashes = PDFGraphics.createDashes(style: style, path: &path)
                expect(dashes).to(haveCount(2))
                expect(dashes) == [3 * width, 3 * width]
                expect(path.lineCapStyle) == CGLineCap.butt
            }

            it("can create dotted dashes") {
                let width: CGFloat = 5
                let style = PDFLineStyle(type: .dotted, color: .red, width: width)

                var path = UIBezierPath()
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: 0, y: 100))

                let dashes = PDFGraphics.createDashes(style: style, path: &path)
                expect(dashes).to(haveCount(2))
                expect(dashes) == [0, 2 * width]
                expect(path.lineCapStyle) == CGLineCap.round
            }

            it("does nothing when not a dashed type") {
                let width: CGFloat = 5
                let style = PDFLineStyle(type: .none, color: .red, width: width)

                var path = UIBezierPath()
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: 0, y: 100))

                let dashes = PDFGraphics.createDashes(style: style, path: &path)
                expect(dashes).to(haveCount(0))
            }

            describe("resizing and compression") {

                let base64String = "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"

                let data: Data! = Data(base64Encoded: base64String)
                expect(data).toNot(beNil())

                var image: UIImage!
                let resultFrame = CGRect(x: 0, y: 0, width: 40, height: 40)

                beforeEach {
                    image = UIImage(data: data)
                    expect(image).toNot(beNil())

                    expect(image.size) == CGSize(width: 61, height: 68)
                }

                it("can resize image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: true,
                                                                    shouldCompress: false,
                                                                    quality: 0.2)
                    expect(result) !== image
                    expect(result.size) == CGSize(width: 25, height: 25)
                }

                it("can compress image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: false,
                                                                    shouldCompress: true,
                                                                    quality: 0.2)
                    expect(result) !== image
                    expect(result.size) == image.size
                }

                it("can resize and compress image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: true,
                                                                    shouldCompress: true,
                                                                    quality: 0.2)
                    expect(result) !== image
                    expect(result.size) == CGSize(width: 25.0, height: 25.0)
                }

                it("can return original image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: false,
                                                                    shouldCompress: false,
                                                                    quality: 0.2)
                    expect(result) === image
                }

                it("can compress an image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: true,
                                                                    shouldCompress: true,
                                                                    quality: 0.0)
                    expect(result) !== image
                }

                it("can resize and compress an image") {
                    let result = PDFGraphics.resizeAndCompressImage(image: image,
                                                                    frame: resultFrame,
                                                                    shouldResize: true,
                                                                    shouldCompress: true,
                                                                    quality: 0.0)
                    expect(result.size) == CGSize(width: 8, height: 8)
                }
            }
        }
    }

}
