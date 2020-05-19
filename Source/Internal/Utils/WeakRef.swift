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
internal class WeakRef<T> where T: AnyObject {

    /**
     Holds a weak reference to an instance
     */
    internal private(set) weak var value: T?

    /**
     Creates a new weak reference instance, holding a reference to the given value

     - parameter value: Value to be weakly referenced
     */
    internal init(value: T?) {
        self.value = value
    }
}
