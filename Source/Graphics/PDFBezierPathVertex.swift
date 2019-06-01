//
//  PDFBezierPathVertex.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 01.06.19.
//

import Foundation
import UIKit

public class PDFBezierPathVertex {

    public enum Anchor {
        case topLeft
        case topCenter
        case topRight

        case middleLeft
        case middleCenter
        case middleRight

        case bottomLeft
        case bottomCenter
        case bottomRight
    }

    public var position: CGPoint
    public var anchor: Anchor

    public init(position: CGPoint, anchor: Anchor) {
        self.position = position
        self.anchor = anchor
    }
}
