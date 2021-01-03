//
//  List.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
public class PDFList: PDFDocumentObject {

    /**
     TODO: Documentation
     */
    internal var items: [PDFListItem] = []

    /**
     TODO: Documentation
     */
    internal var levelIndentations: [(pre: CGFloat, past: CGFloat)] = []

    /**
     TODO: Documentation
     */
    public init(indentations: [(pre: CGFloat, past: CGFloat)]) {
        self.levelIndentations = indentations
    }

    /**
     TODO: Documentation
     */
    @discardableResult public func addItem(_ item: PDFListItem) -> PDFList {
        self.items.append(item)

        return self
    }

    /**
     TODO: Documentation
     */
    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFList {
        self.items += items

        return self
    }

    /**
     TODO: Documentation
     */
    public var count: Int {
        items.count
    }

    /**
     TODO: Documentation
     */
    public func flatted() -> [(level: Int, text: String, symbol: PDFListItemSymbol)] {
        var result: [(level: Int, text: String, symbol: PDFListItemSymbol)] = []
        for (idx, item) in self.items.enumerated() {
            result += flatItem(item: item, level: 0, index: idx)
        }
        return result
    }

    /**
     TODO: Documentation
     */
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

    internal func clear() {
        self.items = []
    }

    /**
     TODO: Documentation
     */
    internal var copy: PDFList {
        let list = PDFList(indentations: self.levelIndentations)
        list.items = items.map(\.copy)
        return list
    }

    // MARK: - Equatable

    /// Compares two instances of `PDFList` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFList`
    ///   - rhs: Another instance of `PDFList`
    /// - Returns: `true`, if `levelIndentations` and `items` equal; otherwise `false`
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherList = other as? PDFList else {
            return false
        }
        guard self.levelIndentations.count == otherList.levelIndentations.count else {
            return false
        }
        for (idx, indentation) in self.levelIndentations.enumerated() where otherList.levelIndentations[idx] != indentation {
            return false
        }
        guard self.items.count == otherList.items.count else {
            return false
        }
        for (idx, item) in self.items.enumerated() where otherList.items[idx] != item {
            return false
        }
        return true
    }

    // MARK: - Hashable

    override public func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        for (pre, post) in levelIndentations {
            hasher.combine(pre)
            hasher.combine(post)
        }
        hasher.combine(items)
    }
}

extension PDFList: CustomDebugStringConvertible {

    public var debugDescription: String {
        "PDFList(levels: \(levelIndentations.debugDescription), items: \(items.debugDescription))"
    }
}

extension PDFList: CustomStringConvertible {

    public var description: String {
        "PDFList(levels: \(levelIndentations), items: \(items))"
    }
}
