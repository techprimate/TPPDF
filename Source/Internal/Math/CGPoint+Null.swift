//
//  CGPoint+Null.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 06.01.20.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

extension CGPoint {
    static var null: CGPoint {
        CGPoint(x: CGFloat.infinity, y: CGFloat.infinity)
    }
}
