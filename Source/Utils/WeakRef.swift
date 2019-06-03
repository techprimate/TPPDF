//
//  WeakRef.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

class WeakRef<T> where T: AnyObject {

    private(set) weak var value: T?

    init(value: T?) {
        self.value = value
    }
}
