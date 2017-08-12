//
//  PDFListItem.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

public class PDFListItem : TPJSONSerializable {
    
    public var parent: PDFListItem?
    public var content: String?
    public var children: [PDFListItem]?
    public var symbol: Symbol
    
    public init(symbol: Symbol = Symbol.inherit, content: String? = nil) {
        self.symbol = symbol
        self.content = content
    }
    
    public func addItem(_ item: PDFListItem) -> PDFListItem {
        item.parent = self
        self.children = (self.children ?? []) + [item]
        return self
    }
    
    public func addItems(_ items: [PDFListItem]) -> PDFListItem {
        for item in items {
            let _ = addItem(item)
        }
        return self
    }
    
    public func setContent(_ content: String) -> PDFListItem {
        self.content = content
        return self
    }
    
    public var JSONRepresentation: AnyObject {
        return "LISTITEM" as NSString
    }
}
