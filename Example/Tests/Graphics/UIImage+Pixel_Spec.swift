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
        describe("UIImage Pixel extension") {

            it("can get pixel color") {
                let size = CGSize(width: 1, height: 1)

                UIGraphicsBeginImageContext(CGSize(width: 2 * size.width, height: 2 * size.height))

                var rect = CGRect(origin: .zero, size: size)
                var path = UIBezierPath(rect: rect)
                UIColor.blue.setFill()
                path.fill()

                rect = CGRect(x: size.width, y: 0, width: size.width, height: size.height)
                path = UIBezierPath(rect: rect)
                UIColor.green.setFill()
                path.fill()

                rect = CGRect(x: 0, y: size.height, width: size.width, height: size.height)
                path = UIBezierPath(rect: rect)
                UIColor.red.setFill()
                path.fill()

                rect = CGRect(x: size.width, y: size.height, width: size.width, height: size.height)
                path = UIBezierPath(rect: rect)
                UIColor.orange.setFill()
                path.fill()

                let _ = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()

                // Position is upside down

//                expect(image.getPixelColor(at: CGPoint(x: 0         , y: 0          ))) == UIColor.red
//                expect(image.getPixelColor(at: CGPoint(x: size.width, y: 0          ))) == UIColor.green
//                expect(image.getPixelColor(at: CGPoint(x: 0         , y: size.height))) == UIColor.red
//                expect(image.getPixelColor(at: CGPoint(x: size.width, y: size.height))) == UIColor.orange
            }
        }
    }
}

