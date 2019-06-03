//
//  PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: Documentation
 */
public class PDFTableContent: PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    enum ContentType: PDFJSONSerializable {

        /**
         TODO: Documentation
         */
        case none

        /**
         TODO: Documentation
         */
        case string

        /**
         TODO: Documentation
         */
        case attributedString

        /**
         TODO: Documentation
         */
        case image

        /**
         TODO: Documentation
         */
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

    /**
     TODO: Documentation
     */
    var type: ContentType = ContentType.none

    /**
     TODO: Documentation
     */
    var content: Any?

    /**
     TODO: Documentation
     */
    public init(content: Any?) throws {
        try self.setContent(content: content)
    }

    /**
     TODO: Documentation
     */
    internal init(type: ContentType, content: Any?) {
        self.type = type
        self.content = content
    }

    /**
     TODO: Documentation
     */
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

    /**
     TODO: Documentation
     */
    var isString: Bool {
        return type == .string
    }

    /**
     TODO: Documentation
     */
    var isAttributedString: Bool {
        return type == .attributedString
    }

    /**
     TODO: Documentation
     */
    var isImage: Bool {
        return type == .image
    }

    /**
     TODO: Documentation
     */
    var stringValue: String? {
        return type == .string ? content as? String : nil
    }

    /**
     TODO: Documentation
     */
    var attributedStringValue: NSAttributedString? {
        return type == .attributedString ? content as? NSAttributedString : nil
    }

    /**
     TODO: Documentation
     */
    var imageValue: UIImage? {
        return type == .image ? content as? UIImage : nil
    }
}

/**
 TODO: Documentation
 */
public extension String {

    /**
     TODO: Documentation
     */
    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .string, content: self)
    }
}

/**
 TODO: Documentation
 */
public extension NSAttributedString {

    /**
     TODO: Documentation
     */
    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .attributedString, content: self)
    }
}

/**
 TODO: Documentation
 */
public extension UIImage {

    func toPDFTableContent() -> PDFTableContent {
        return PDFTableContent(type: .image, content: self)
    }
}
