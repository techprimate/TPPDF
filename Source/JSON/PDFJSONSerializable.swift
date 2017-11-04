//
//  JSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

public protocol PDFJSONSerializable: PDFJSONRepresentable { }

public extension PDFJSONSerializable {
    
    public func toJSON(options: JSONSerialization.WritingOptions = []) -> String? {
        let representation = JSONRepresentation
        
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: options)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
            return nil
        }
    }
}

extension PDFJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        var representation = [String: AnyObject]()
        
        for case let (label?, value) in Mirror(reflecting: self).children {
            representation[label] = convertValue(value)
        }
        
        return representation as AnyObject
    }
}

extension PDFJSONSerializable {
    
    func convertValue(_ value: Any) -> AnyObject {
        if let value = value as? PDFJSONSerializable {
            return value.JSONRepresentation
        } else if let value = value as? NSString {
            return value
        } else if let value = value as? NSNumber {
            return value
        } else if isTuple(value: value) {
            return serializeTuple(value)
        } else if Mirror(reflecting: value).displayStyle == .optional {
            // TODO: Do not return NSNull if optional has content
            return NSNull()
        } else {
            return "UNKNOWN" as NSString
        }
    }
    
    func isTuple(value: Any) -> Bool {
        return Mirror(reflecting: value).displayStyle == .tuple
    }
    
    func serializeTuple(_ value: Any) -> AnyObject {
        let mirror = Mirror(reflecting: value)
        var i = 0
        var result: [String: Any] = [:]
        
        for (label, value) in mirror.children {
            result[label ?? "\(i)"] = value
            i += 1
        }
        return result.JSONRepresentation
    }
}

extension Array: PDFJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        var representation: [Any] = []
        
        for (value) in self {
            representation.append(convertValue(value))
        }
        
        return representation as NSArray
    }
}

extension Dictionary: PDFJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        let representation: NSMutableDictionary = [:]
        
        for (key, value) in self {
            representation[key] = convertValue(value)
        }
        
        return representation as NSDictionary
    }
}

extension CGRect: PDFJSONSerializable { }
extension CGPoint: PDFJSONSerializable { }
extension CGSize: PDFJSONSerializable { }

extension NSAttributedString: PDFJSONSerializable { }
extension UIFont: PDFJSONSerializable { }

extension UIImage: PDFJSONSerializable {
    
    public var JSONRepresentation: AnyObject {
        return UIImageJPEGRepresentation(self, 1.0)?.base64EncodedString() as AnyObject? ?? NSNull()
    }
}

extension UIColor: PDFJSONSerializable {
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255) << 16 | (Int)(g*255) << 8 | (Int)(b*255) << 0
        
        return String(format: "#%06x", rgb)
    }
    
    public var JSONRepresentation: AnyObject {
        return self.toHexString() as NSString
    }
}
