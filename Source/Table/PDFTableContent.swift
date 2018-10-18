//
//  PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public class PDFTableContent: PDFJSONSerializable {

    enum ContentType: PDFJSONSerializable {

        case none
        case string
        case attributedString
        case image

        var JSONRepresentation: AnyObject {
            switch self {
            case .none:
                return 0 as AnyObject
            case .string:
                return 1 as AnyObject
            case .attributedString:
                return 2 as AnyObject
            case .image:
                return 3 as AnyObject
            }
        }
    }

    var type: ContentType = ContentType.none
    var content: Any?

    public init(content: Any?) throws {
        try self.setContent(content: content)
    }

    internal init(type: ContentType, content: Any?) {
        self.type = type
        self.content = content
    }

    func setContent(content: Any?) throws {
        if content == nil {
            self.type = .none
            self.content = nil
        } else if content is String {
            self.type = .string
            self.content = content
        } else if content is UIImage {
            self.type = .image
            self.content = content
        } else if content is NSAttributedString {
            self.type = .attributedString
            self.content = content
        } else if content is Int || content is Double || content is Float {
            self.type = .string
            self.content = String(describing: content!)
        } else {
            throw PDFError.tableContentInvalid(value: content)
        }
    }

    var isString: Bool {
        return type == .string
    }

    var isAttributedString: Bool {
        return type == .attributedString
    }

    var isImage: Bool {
        return type == .image
    }

    var stringValue: String? {
        return type == .string ? content as? String : nil
    }

    var attributedStringValue: NSAttributedString? {
        return type == .attributedString ? content as? NSAttributedString : nil
    }

    var imageValue: UIImage? {
        return type == .image ? content as? UIImage : nil
    }

}

public extension String {

    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .string, content: self)
    }

}

public extension NSAttributedString {

    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .attributedString, content: self)
    }

}

public extension UIImage {

    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .image, content: self)
    }

}
