//
//  PDFListItem.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public class PDFListItem: PDFJSONSerializable {

    public weak var parent: PDFListItem?
    public var content: String?
    public var children: [PDFListItem]?
    public var symbol: PDFListItemSymbol

    public init(symbol: PDFListItemSymbol = PDFListItemSymbol.inherit, content: String? = nil) {
        self.symbol = symbol
        self.content = content
    }

    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFListItem {
        for item in items {
            _ = addItem(item)
        }

        return self
    }

    @discardableResult public func addItem(_ item: PDFListItem) -> PDFListItem {
        item.parent = self
        self.children = (self.children ?? []) + [item]

        return self
    }

    @discardableResult public func setContent(_ content: String) -> PDFListItem {
        self.content = content

        return self
    }

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
