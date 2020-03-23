//
//  PDFJSONSerializable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 TODO: Documentation
 */
public protocol PDFJSONSerializable: PDFJSONRepresentable {}

/**
 TODO: Documentation
 */
extension PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var JSONRepresentation: AnyObject {
        var representation = [String: AnyObject]()

        for case let (label?, value) in Mirror(reflecting: self).children {
            representation[label] = convertValue(value)
        }

        return representation as AnyObject
    }
}

/**
 TODO: Documentation
 */
public extension PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    func toJSON(options: JSONSerialization.WritingOptions = []) -> String? {
        let representation = JSONRepresentation

        guard JSONSerialization.isValidJSONObject(representation),
            let data = try? JSONSerialization.data(withJSONObject: representation, options: options) else {
                print("Invalid JSON from representation.")
                return nil
        }

        return String(data: data, encoding: .utf8)
    }

    /**
     TODO: Documentation
     */
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

    /**
     TODO: Documentation
     */
    func isTuple(value: Any) -> Bool {
        return Mirror(reflecting: value).displayStyle == .tuple
    }

    /**
     TODO: Documentation
     */
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
