//
//  PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

public protocol PDFJSONSerializable: PDFJSONRepresentable {}

public extension PDFJSONSerializable {

    public func toJSON(options: JSONSerialization.WritingOptions = []) -> String? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation),
            let data = try? JSONSerialization.data(withJSONObject: representation, options: options) else {
            print("Invalid JSON from representation.")
            return nil
        }

        return String(data: data, encoding: .utf8)
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
            return NSNull()
        }
        return "UNKNOWN" as AnyObject
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

extension CGRect: PDFJSONSerializable {}
extension CGPoint: PDFJSONSerializable {}
extension CGSize: PDFJSONSerializable {}

extension NSAttributedString: PDFJSONSerializable {}
extension UIFont: PDFJSONSerializable {}

extension UIImage: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.jpegData(compressionQuality: 1.0)?.JSONRepresentation ?? NSNull()
    }

}

extension Data: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.base64EncodedString() as AnyObject
    }

}

extension UIColor: PDFJSONSerializable {

    public var JSONRepresentation: AnyObject {
        return self.hex as AnyObject
    }

}
