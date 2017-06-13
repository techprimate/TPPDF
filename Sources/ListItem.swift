//
//  ListItem.swift
//  Pods
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

open class ListItem: CustomStringConvertible {
    
    open var parent: ListItem?
    open var content: String?
    open var children: [ListItem]?
    open var symbol: Symbol
    
    public init(symbol: Symbol = Symbol.inherit, content: String? = nil) {
        self.symbol = symbol
        self.content = content
    }
    
    public func addItem(_ item: ListItem) -> ListItem {
        item.parent = self
        self.children = (self.children ?? []) + [item]
        return self
    }
    
    public func addItems(_ items: [ListItem]) -> ListItem {
        for item in items {
            addItem(item)
        }
        return self
    }
    
    public func setContent(_ content: String) -> ListItem {
        self.content = content
        return self
    }
    
    public var description: String {
        return "[ListItem]<content: \(content), symbol: \(symbol.rawValue)>"
    }
}
