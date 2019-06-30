//
//  CustomStringConvertible+AutoDescribing.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.06.19.
//

import Foundation

extension CustomStringConvertible {

    public var description: String {
        var description: String = ""
        if self is AnyObject {
            description = String(format: "%@<%@>", String(describing: type(of: self)), Unmanaged.passUnretained(self as AnyObject).toOpaque().debugDescription)
        } else {
            description = String(describing: type(of: self))
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

    public var debugDescription: String {
        var description: String = ""
        if self is AnyObject {
            description = String(format: "%@<%@>", String(describing: type(of: self)), Unmanaged.passUnretained(self as AnyObject).toOpaque().debugDescription)
        } else {
            description = String(describing: type(of: self))
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
