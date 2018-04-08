//
//  List.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public class PDFList: PDFJSONSerializable {

    var items: [PDFListItem] = []
    var levelIndentations: [(pre: CGFloat, past: CGFloat)] = []

    public init(indentations: [(pre: CGFloat, past: CGFloat)]) {
        self.levelIndentations = indentations
    }

    @discardableResult public func addItem(_ item: PDFListItem) -> PDFList {
        self.items.append(item)

        return self
    }

    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFList {
        self.items += items

        return self
    }

    public var count: Int {
        return items.count
    }

    public func flatted() -> [(level: Int, text: String, symbol: PDFListItemSymbol)] {
        var result: [(level: Int, text: String, symbol: PDFListItemSymbol)] = []
        for (idx, item) in self.items.enumerated() {
            result += flatItem(item: item, level: 0, index: idx)
        }
        return result
    }

    private func flatItem(item: PDFListItem, level: Int, index: Int) -> [(level: Int, text: String, symbol: PDFListItemSymbol)] {
        var result: [(level: Int, text: String, symbol: PDFListItemSymbol)] = []
        if let content = item.content {
            var symbol: PDFListItemSymbol = .inherit
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
                result += flatItem(item: child, level: level + (item.content == nil ? 0 : 1), index: idx)
            }
        }
        return result
    }

    func clear() {
        self.items = []
    }

    var copy: PDFList {
        let list = PDFList(indentations: self.levelIndentations)
        list.items = items
        return list
    }

}
