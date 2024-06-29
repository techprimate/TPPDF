//
//  PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Structure used to manage cell content
public class PDFTableContent: CustomStringConvertible, Hashable {
    /// Type of the content
    var type: ContentType = .none

    /// Content of a cell
    var content: Any?

    /**
     * Creates a new table cell content wrapping the given `content
     *
     * - Parameter content: Content of this cell, see ``ContentType`` for list of supported types.
     *
     * - Throws: ``PDFError/tableContentInvalid(value:)`` if the `content` has an unsupported type
     */
    public init(content: Any?) throws {
        try setContent(content: content)
    }

    /**
     * Creates a new table cell content with a pre-defined `type` and `content`.
     *
     * - Parameter content: Content of this cell, see ``ContentType`` for list of supported types.
     * - Note: This initializer should remain internal, so that accidentally setting the wrong `type` for a `content` can be avoided
     */
    init(type: ContentType, content: Any?) {
        self.type = type
        self.content = content
    }

    /**
     * Sets the ``PDFTableContent/content`` and ``PDFTableContent/type`` based on the given `content`.
     *
     * - Parameter content: Content of this cell, see ``ContentType`` for list of supported types.
     *
     * - Throws: ``PDFError/tableContentInvalid(value:)`` if the `content` has an unsupported type
     */
    func setContent(content: Any?) throws {
        if content == nil {
            type = .none
            self.content = nil
        } else if content is String {
            type = .string
            self.content = content
        } else if content is Image {
            type = .image
            self.content = content
        } else if content is NSAttributedString {
            type = .attributedString
            self.content = content
        } else if content is Int || content is Double || content is Float {
            type = .string
            self.content = String(describing: content!)
        } else {
            throw PDFError.tableContentInvalid(value: content)
        }
    }

    /// Convenience accessor for testing the ``PDFTableContent/type``
    var isString: Bool {
        type == .string
    }

    /// Convenience accessor for testing the ``PDFTableContent/type``
    var isAttributedString: Bool {
        type == .attributedString
    }

    /// Convenience accessor for testing the ``PDFTableContent/type``
    var isImage: Bool {
        type == .image
    }

    /// Convenience accessor for casting the ``PDFTableContent/content`` based on  the ``PDFTableContent/type``
    var stringValue: String? {
        type == .string ? content as? String : nil
    }

    /// Convenience accessor for casting the ``PDFTableContent/content`` based on  the ``PDFTableContent/type``
    var attributedStringValue: NSAttributedString? {
        type == .attributedString ? content as? NSAttributedString : nil
    }

    /// Convenience accessor for casting the ``PDFTableContent/content`` based on  the ``PDFTableContent/type``
    var imageValue: Image? {
        type == .image ? content as? Image : nil
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFTableContent, rhs: PDFTableContent) -> Bool {
        guard lhs.type == rhs.type else {
            return false
        }
        if let lhsString = lhs.content as? String,
           let rhsString = rhs.content as? String,
           lhsString != rhsString {
            return false
        } else if let lhsString = lhs.content as? NSAttributedString,
                  let rhsString = rhs.content as? NSAttributedString,
                  lhsString != rhsString {
            return false
        } else if let lhsImage = lhs.content as? Image,
                  let rhsImage = rhs.content as? Image,
                  lhsImage != rhsImage {
            return false
        } else if (lhs.content == nil && rhs.content != nil) || (lhs.content != nil && rhs.content == nil) {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        switch type {
        case .string:
            hasher.combine(stringValue)
        case .attributedString:
            hasher.combine(attributedStringValue)
        case .image:
            hasher.combine(imageValue)
        case .none:
            hasher.combine("none")
        }
    }
}

// MARK: PDFTableContentable

extension PDFTableContent: PDFTableContentable {
    /// Casts this instance to a ``PDFTableContent``
    public var asTableContent: PDFTableContent {
        self
    }
}
