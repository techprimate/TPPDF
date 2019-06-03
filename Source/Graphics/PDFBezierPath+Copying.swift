//
//  PDFBezierPath+Copying.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.06.19.
//

import Foundation
import UIKit

extension PDFBezierPath: NSCopying {

    public func copy(with zone: NSZone? = nil) -> Any {
        let path = PDFBezierPath(ref: self.refFrame)
        path.elements = self.elements
        return path
    }
}
