//
//  Stack.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 29.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
public struct Stack<T> {

    /**
     TODO: Documentation
     */
    fileprivate var array = [T]()

    /**
     TODO: Documentation
     */
    public init(values: T...) {
        array.append(contentsOf: values)
    }

    /**
     TODO: Documentation
     */
    public var isEmpty: Bool {
        return array.isEmpty
    }

    /**
     TODO: Documentation
     */
    public var count: Int {
        return array.count
    }

    /**
     TODO: Documentation
     */
    @discardableResult
    public mutating func push(_ element: T) -> Stack<T> {
        array.append(element)
        return self
    }

    /**
     TODO: Documentation
     */
    @discardableResult
    public mutating func pop(to count: Int? = nil) -> T? {
        if let count = count {
            var value: T?
            while self.count > count {
                value = array.popLast()
            }
            return value
        }
        return array.popLast()
    }

    /**
     TODO: Documentation
     */
    public func peek(at index: Int) -> T? {
        guard index >= 0 && index < count else {
            return nil
        }
        return array[index]
    }

    /**
     TODO: Documentation
     */
    public var top: T? {
        return array.last
    }

    /**
     TODO: Documentation
     */
    public func fromTop(index: Int) -> T? {
        let i = array.count - 1 - index
        return i < 0 ? nil : array[i]
    }
}

extension Stack: CustomStringConvertible where T: CustomStringConvertible {

    public var description: String {
        return array.map({ $0.description }).joined(separator: "\n")
    }
}

extension Stack: CustomDebugStringConvertible where T: CustomDebugStringConvertible {

    public var debugDescription: String {
        return array.map({ $0.debugDescription }).joined(separator: "\n")
    }
}
