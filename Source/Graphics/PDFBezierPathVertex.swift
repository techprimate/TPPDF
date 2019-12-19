//
//  PDFBezierPathVertex.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

import Foundation
import UIKit

/**
 TODO: Documentation
 */
public class PDFBezierPathVertex: CustomStringConvertible {

    /**
     TODO: Documentation
     */
    public enum Anchor {
        /**
         TODO: Documentation
         */
        case topLeft

        /**
         TODO: Documentation
         */
        case topCenter

        /**
         TODO: Documentation
         */
        case topRight

        /**
         TODO: Documentation
         */
        case middleLeft

        /**
         TODO: Documentation
         */
        case middleCenter

        /**
         TODO: Documentation
         */
        case middleRight

        /**
         TODO: Documentation
         */
        case bottomLeft

        /**
         TODO: Documentation
         */
        case bottomCenter

        /**
         TODO: Documentation
         */
        case bottomRight
    }

    /**
     TODO: Documentation
     */
    public var position: CGPoint

    /**
     TODO: Documentation
     */
    public var anchor: Anchor

    /**
     TODO: Documentation
     */
    public init(position: CGPoint, anchor: Anchor) {
        self.position = position
        self.anchor = anchor
    }
}
