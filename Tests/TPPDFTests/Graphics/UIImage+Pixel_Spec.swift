//
//  Image+Pixel_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import CoreGraphics
import Quick
import Nimble
@testable import TPPDF

class Image_Pixel_Spec: QuickSpec {

    override func spec() {
        describe("Image") {

            context("Pixel") {
                it("can get pixel color") {
                    let size = CGSize(width: 2, height: 2)
                    let context = PDFContextGraphics.createBitmapContext(size: size)!

                    context.setFillColor(Color.blue.cgColor)
                    context.fill(.init(x: 0, y: 0, width: 1, height: 1))

                    context.setFillColor(Color.green.cgColor)
                    context.fill(.init(x: 1, y: 0, width: 1, height: 1))

                    context.setFillColor(Color.red.cgColor)
                    context.fill(.init(x: 0, y: 1, width: 1, height: 1))

                    context.setFillColor(Color.orange.cgColor)
                    context.fill(.init(x: 1, y: 1, width: 1, height: 1))

                    let image = PDFContextGraphics.getImage(from: context, size: size)!
                    
                    // Position is upside down

                    expect(image.size) == CGSize(width: 2, height: 2)
                    expect(image.pixelColor(at: CGPoint(x: 0, y: 1))) == Color.blue
                    expect(image.pixelColor(at: CGPoint(x: 1, y: 1))) == Color.green
                    expect(image.pixelColor(at: CGPoint(x: 0, y: 0))) == Color.red
                    expect(image.pixelColor(at: CGPoint(x: 1, y: 0)).isClose(to: Color.orange, decimals: 2)).to(beTrue())
                }
            }
        }
    }

}
