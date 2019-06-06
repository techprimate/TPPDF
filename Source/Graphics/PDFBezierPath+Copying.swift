//
//  PDFBezierPath+Copying.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 03.06.19.
//

import Foundation
import UIKit

/**
 TODO: Documentation
 */
extension PDFBezierPath: NSCopying {

    /**
     TODO: Documentation
     */
    public func copy(with zone: NSZone? = nil) -> Any {
        let path = PDFBezierPath(ref: self.refFrame)
        path.elements = self.elements
        return path
    }
}
