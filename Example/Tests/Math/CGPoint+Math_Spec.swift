//
//  CGPoint+Math_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 05/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class CGPoint_Math_Spec: QuickSpec {

    override func spec() {
        describe("CGPoint") {

            let point = CGPoint(x: 10, y: 20)

            it("can be added to a CGPoint") {
                let point2 = CGPoint(x: 30, y: 40)

                expect(point + point2) == CGPoint(x: 40, y: 60)
            }

            it("can be subtracted from a point") {
                let point2 = CGPoint(x: 30, y: 40)

                expect(point - point2) == CGPoint(x: -20, y: -20)
            }

            it("can be added by a value") {
                let value: CGFloat = 20

                expect(point + value) == CGPoint(x: 30, y: 40)
            }
        }
    }

}
