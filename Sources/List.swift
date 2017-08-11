//
//  List.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

open class List {
    
    var items: [ListItem] = []
    var levelIndentations: [(pre: CGFloat, past: CGFloat)] = []
    
    public init(indentations: [(pre: CGFloat, past: CGFloat)]) {
        self.levelIndentations = indentations
    }
    
    public func addItem(_ item: ListItem) {
        self.items.append(item)
    }
    
    public func addItems(_ items: [ListItem]) {
        self.items = self.items + items
    }
    
    public var count: Int {
        return items.count
    }
    
    public func flatted() -> [(level: Int, text: String, symbol: ListItem.Symbol)] {
        var result: [(level: Int, text: String, symbol: ListItem.Symbol)] = []
        for (idx, item) in self.items.enumerated() {
            result = result + flatItem(item: item, level: 0, index: idx)
        }
        return result
    }
    
    private func flatItem(item: ListItem, level: Int, index: Int) -> [(level: Int, text: String, symbol: ListItem.Symbol)] {
        var result: [(level: Int, text: String, symbol: ListItem.Symbol)] = []
        if let content = item.content {
            var symbol: ListItem.Symbol = .inherit
            if item.symbol == .inherit {
                if let parent = item.parent {
                    if parent.symbol == .numbered(value: nil) {
                        symbol = .numbered(value: "\(index + 1)")
                    } else {
                        symbol = parent.symbol
                    }
                }
            } else {
                symbol = item.symbol
            }
            result = [(level: level, text: content, symbol: symbol)]
        }
        if let children = item.children {
            for (idx, child) in children.enumerated() {
                result = result + flatItem(item: child, level: level + (item.content == nil ? 0 : 1), index: idx)
            }
        }
        return result
    }
    
    func clear() {
        self.items = []
    }
    
}

