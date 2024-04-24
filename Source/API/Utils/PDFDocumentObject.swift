//
//  PDFDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.19.
//

/// All document objects are instances of ``PDFDocumentObject`` to share common properties, e.g. `attributes`.
public class PDFDocumentObject: PDFAttributableObject, PDFTaggableObject, Hashable {
    /// List of ``PDFObjectAttribute`` to be applied during calculations and rendering
    public var attributes: [PDFObjectAttribute] = []

    /// An integer that you can use to identify view objects in delegates.
    public var tag: Int = 0

    /// nodoc
    public init() {}

    /**
     * Appends the given `attribute` to the list of ``PDFDocumentObject/attributes``.
     *
     * Attributes should be considered as independend from the implementation of the object.
     * An example are clickable links, which can be applied to most objects and will be added as a interactive,
     * rectangular area in the document, opening the configured link.
     *
     * - Parameter attribute: ``PDFObjectAttribute`` to append to list
     *
     * - Note: Multiple instances of the same ``PDFObjectAttribute`` can be appended and might lead to unexpected results.
     */
    public func add(attribute: PDFObjectAttribute) {
        attributes.append(attribute)
    }

    // MARK: - Equatable

    /// nodoc
    public static func == (lhs: PDFDocumentObject, rhs: PDFDocumentObject) -> Bool {
        lhs.isEqual(to: rhs)
    }

    /// nodoc
    public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard attributes == other.attributes else { return false }
        guard tag == other.tag else { return false }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    public func hash(into hasher: inout Hasher) {
        hasher.combine(attributes)
        hasher.combine(tag)
    }
}
