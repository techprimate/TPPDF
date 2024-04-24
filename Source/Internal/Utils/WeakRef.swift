//
//  WeakRef.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

/**
 Utility class used for weak reference wrapping
 */
class WeakRef<T> where T: AnyObject {
    /**
     Holds a weak reference to an instance
     */
    private(set) weak var value: T?

    /**
     Creates a new weak reference instance, holding a reference to the given value

     - Parameter value: Value to be weakly referenced
     */
    init(value: T?) {
        self.value = value
    }
}
