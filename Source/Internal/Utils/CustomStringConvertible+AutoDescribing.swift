//
//  CustomStringConvertible+AutoDescribing.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.06.19.
//

import Foundation

extension CustomStringConvertible {

    /**
     Default implementation for `description` using class reflection to create a comma concatenated list of properties and values

     - Returns: String of comma-separated key/value pairs
     */
    public var description: String {
        var description: String = ""
        description = withUnsafePointer(to: self) { pointer in
            String(format: "%@<%p>", String(describing: type(of: self)), pointer)
        }
        let selfMirror = Mirror(reflecting: self)
        return String(format: "%@(%@)",
                      description,
                      selfMirror.children
                        .compactMap({ child in
                            if let propertyName = child.label {
                                return "\(propertyName): \(child.value)"
                            }
                            return nil
                        })
                        .joined(separator: ", "))
    }
}

extension CustomDebugStringConvertible {

    /**
     Default implementation for `debugDescription` using class reflection to create a comma concatenated list of properties and values

     - Returns: String of comma-separated key/value pairs
     */
    public var debugDescription: String {
        var description: String = ""
        description = String(format: "%@<%@>",
                             String(describing: type(of: self)),
                             Unmanaged.passUnretained(self as AnyObject).toOpaque().debugDescription)
        let selfMirror = Mirror(reflecting: self)
        return String(format: "%@(%@)",
                      description,
                      selfMirror.children
                        .compactMap({ child in
                            if let propertyName = child.label {
                                return "\(propertyName): \(child.value)"
                            }
                            return nil
                        })
                        .joined(separator: ", "))
    }
}
