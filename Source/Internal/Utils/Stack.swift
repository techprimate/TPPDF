//
//  Stack.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 29.05.19.
//

import Foundation

/**
 Data Structure used to manage a collection of elements after the LIFO (last in, first out) principle.
 */
public struct Stack<T> {

    /**
     Data structure used to manage elements
     */
    fileprivate var array = [T]()

    /**
     Creates a new stack with the given elements.
     */
    public init(values: T...) {
        array.append(contentsOf: values)
    }

    /**
     - returns: `true` if element count is zero, `false` otherwise
     */
    public var isEmpty: Bool {
        array.isEmpty
    }

    /**
     - returns: Number of elements in stack
     */
    public var count: Int {
        array.count
    }

    /**
     Adds an element on top of the stack

     - parameter element: Element to be pushed on top of stack

     - returns: Instance of stack for chaining
     */
    @discardableResult
    public mutating func push(_ element: T) -> Stack<T> {
        array.append(element)
        return self
    }

    /**
     Removes the last element or if a `count` is given as many until the stack is empty.
     Afterwards it returns the last removed element.

     - parameter count: Amount of elements to remove, can be nil

     - returns: Last element which was removed, or nil if stack is empty
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
     Returns the element at the given index without changing the stack

     - parameter index: from bottom up

     - returns: element at `index` or nil if out of bounds
     */
    public func peek(at index: Int) -> T? {
        guard index >= 0 && index < count else {
            return nil
        }
        return array[index]
    }

    /**
     Returns the last inserted element

     - returns: Element` or nil if empty
     */
    public var top: T? {
        array.last
    }

    /**
     Returns the element from the reverse order

     - parameter index: distance to most top element

     - returns: element at `index` or nil if out of bounds
     */
    public func fromTop(index: Int) -> T? {
        let i = array.count - 1 - index
        return i < 0 ? nil : array[i]
    }
}

extension Stack: CustomStringConvertible where T: CustomStringConvertible {

    public var description: String {
        withUnsafePointer(to: self) { pointer in
            String(format: "Stack<%p> { %@ }", pointer, array.map(\.description).joined(separator: "\n"))
        }
    }
}

extension Stack: CustomDebugStringConvertible where T: CustomDebugStringConvertible {

    public var debugDescription: String {
        withUnsafePointer(to: self) { pointer in
            String(format: "Stack<%p> { %@ }", pointer, array.map(\.debugDescription).joined(separator: "\n"))
        }
    }
}
