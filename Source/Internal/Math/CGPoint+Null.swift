//
//  CGPoint+Null.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.01.20.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension CGPoint {

    internal static var null: CGPoint {
        CGPoint(x: CGFloat.infinity, y: CGFloat.infinity)
    }
}
