//
//  CustomStringConvertible+AutoDescribing.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.06.19.
//

import Foundation

extension CustomStringConvertible {

    /**
     TODO: docs
     */
    public var description: String {
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

extension CustomDebugStringConvertible {

    /**
     TODO: docs
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
