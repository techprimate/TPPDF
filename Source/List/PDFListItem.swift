//
//  PDFListItem.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: documentation
 */
public class PDFListItem {

    /**
     TODO: documentation
     */
    public weak var parent: PDFListItem?

    /**
     TODO: documentation
     */
    public var content: String?

    /**
     TODO: documentation
     */
    public var children: [PDFListItem]?

    /**
     TODO: documentation
     */
    public var symbol: PDFListItemSymbol

    /**
     TODO: documentation
     */
    public init(symbol: PDFListItemSymbol = PDFListItemSymbol.inherit, content: String? = nil) {
        self.symbol = symbol
        self.content = content
    }

    /**
     TODO: documentation
     */
    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFListItem {
        for item in items {
            _ = addItem(item)
        }

        return self
    }

    /**
     TODO: documentation
     */
    @discardableResult public func addItem(_ item: PDFListItem) -> PDFListItem {
        item.parent = self
        self.children = (self.children ?? []) + [item]

        return self
    }

    /**
     TODO: documentation
     */
    @discardableResult public func setContent(_ content: String) -> PDFListItem {
        self.content = content

        return self
    }

    /**
     TODO: documentation
     */
    public var copy: PDFListItem {
        let item = PDFListItem(symbol: self.symbol, content: self.content)
        for child in children ?? [] {
            item.addItem(child.copy)
        }
        return item
    }
}

extension PDFListItem: PDFJSONSerializable {

    /**
     TODO: documentation
     */
    public var JSONRepresentation: AnyObject {
        var representation: [String: AnyObject] = [:]
        if let content = content {
            representation["content"] = content as AnyObject
        }
        representation["symbol"] = symbol.JSONRepresentation

        if let children = children {
            let result = children.map { child -> AnyObject in
                return child.JSONRepresentation
                } as AnyObject

            representation["children"] = result
        }
        return representation as AnyObject
    }
}
