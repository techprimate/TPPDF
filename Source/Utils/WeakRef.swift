//
//  WeakRef.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
internal class WeakRef<T> where T: AnyObject {

    /**
     TODO: Documentation
     */
    internal private(set) weak var value: T?

    /**
     TODO: Documentation
     */
    internal init(value: T?) {
        self.value = value
    }
}
