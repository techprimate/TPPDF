//
//  UIImage+Pixel_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class UIImage_Pixel_Spec: QuickSpec {

    override func spec() {
        describe("UIImage") {

            context("Pixel") {
                it("can get pixel color") {
                    UIGraphicsBeginImageContext(CGSize(width: 2, height: 2))

                    var rect = CGRect(x: 0, y: 0, width: 1, height: 1)
                    var path = UIBezierPath(rect: rect)
                    UIColor.blue.setFill()
                    path.fill()

                    rect = CGRect(x: 1, y: 0, width: 1, height: 1)
                    path = UIBezierPath(rect: rect)
                    UIColor.green.setFill()
                    path.fill()

                    rect = CGRect(x: 0, y: 1, width: 1, height: 1)
                    path = UIBezierPath(rect: rect)
                    UIColor.red.setFill()
                    path.fill()

                    rect = CGRect(x: 1, y: 1, width: 1, height: 1)
                    path = UIBezierPath(rect: rect)
                    UIColor.orange.setFill()
                    path.fill()

                    let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()

                    // Position is upside down

                    expect(image.size) == CGSize(width: 2, height: 2)
                    expect(image.pixelColor(at: CGPoint(x: 0, y: 0))) == UIColor.blue
                    expect(image.pixelColor(at: CGPoint(x: 1, y: 0))) == UIColor.green
                    expect(image.pixelColor(at: CGPoint(x: 0, y: 1))) == UIColor.red
                    expect(image.pixelColor(at: CGPoint(x: 1, y: 1)).isClose(to: UIColor.orange, decimals: 2)).to(beTrue())
                }
            }
        }
    }

}
