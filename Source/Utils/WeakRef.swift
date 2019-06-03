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
class WeakRef<T> where T: AnyObject {

    /**
     TODO: Documentation
     */
    private(set) weak var value: T?

    /**
     TODO: Documentation
     */
    init(value: T?) {
        self.value = value
    }
}
