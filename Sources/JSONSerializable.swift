//
//  JSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

import Foundation

public protocol TPJSONSerializable : TPJSONRepresentable { }

public extension TPJSONSerializable {
    
    public func toJSON(options: JSONSerialization.WritingOptions = []) -> String? {
        let representation = JSONRepresentation
        
        guard JSONSerialization.isValidJSONObject(representation) else {
            return nil
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: options)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}

extension TPJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        var representation = [String: AnyObject]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as TPJSONRepresentable:
                representation[label] = value.JSONRepresentation
                break
            case let value as NSObject:
                representation[label] = value
                break
            default:
                if isTuple(value: value) {
                    representation[label] = serializeTuple(value)
                } else if Mirror(reflecting: value).displayStyle == .optional {
                    representation[label] = NSNull()
                } else {
                    representation[label] = "UNKNOWN" as NSString
                }
                break
            }
        }
        return representation as AnyObject
    }
}

extension TPJSONSerializable {
    
    func serializeTuple(_ value: Any) -> AnyObject {
        let mirror = Mirror(reflecting: value)
        var i = 0
        var result: [String : Any] = [:]
        
        for (label, value) in mirror.children {
            result[label ?? "\(i)"] = value
            i += 1
        }
        return result.JSONRepresentation
    }
    
    func isTuple(value: Any) -> Bool {
        return Mirror(reflecting: value).displayStyle == .tuple
    }
}


extension Array : TPJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        var representation: [Any] = []
        
        for (value) in self {
            switch value {
            case let value as TPJSONSerializable:
                representation.append(value.JSONRepresentation)
                break
            case let value as NSObject:
                representation.append(value)
                break
            default:
                if isTuple(value: value) {
                    representation.append(serializeTuple(value))
                } else if Mirror(reflecting: value).displayStyle == .optional {
                    representation.append(NSNull())
                } else {
                    representation.append("UNKNOWN")
                }
                break
            }
        }
        
        return representation as NSArray
    }
}

extension Dictionary : TPJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        let representation: NSMutableDictionary = [:]
        
        for (key, value) in self {
            switch value {
            case let value as TPJSONSerializable:
                representation[key] = value.JSONRepresentation
                break
            case let value as NSObject:
                representation[key] = value
                break
            default:
                if isTuple(value: value) {
                    representation[key] = serializeTuple(value)
                } else if Mirror(reflecting: value).displayStyle == .optional {
                    representation[key] = NSNull()
                } else {
                    representation[key] = "UNKNOWN" as NSString
                }
                break
            }
            
        }
        
        return representation as NSDictionary
    }
}

extension CGRect  : TPJSONSerializable { }
extension CGPoint : TPJSONSerializable { }
extension CGSize  : TPJSONSerializable { }

extension NSAttributedString : TPJSONSerializable { }
extension UIFont: TPJSONSerializable { }

extension UIImage : TPJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        return "IMAGE" as NSString
//        return (UIImageJPEGRepresentation(self, 1.0)?.base64EncodedString() as? NSString) ?? NSNull()
    }
}

extension UIColor : TPJSONSerializable {
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255) << 16 | (Int)(g*255) << 8 | (Int)(b*255) << 0
        
        return String(format:"#%06x", rgb)
    }
    
    public var JSONRepresentation: AnyObject {
        return self.toHexString() as NSString
    }
}

