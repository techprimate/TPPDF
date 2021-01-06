//
//  PDFDocumentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.19.
//

public class PDFDocumentObject: PDFAttributableObject, PDFTaggableObject, Hashable {

    public var attributes: [PDFObjectAttribute] = []
    public var tag: Int = 0

    public init() {}

    public func add(attribute: PDFObjectAttribute) {
        attributes.append(attribute)
    }

    // MARK: - Equatable

    public static func == (lhs: PDFDocumentObject, rhs: PDFDocumentObject) -> Bool {
        lhs.isEqual(to: rhs)
    }

    public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard self.attributes == other.attributes else { return false }
        guard self.tag == other.tag else { return false }
        return true
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(attributes)
        hasher.combine(tag)
    }
}
