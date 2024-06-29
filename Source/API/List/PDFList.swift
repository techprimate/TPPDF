//
//  PDFList.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Creates a new bullet list or numbered list with multiple, indented levels.
 *
 * Each list item has a `pre` spacing between the page indentation to the left side of the ``PDFListItem/symbol``, and a `past` spacing at
 * the right side of the symbol.
 *
 * ```swift
 * let list = PDFList(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
 * ```
 */
public class PDFList: PDFDocumentObject {
    /// Items in this list
    public var items: [PDFListItem] = []

    /// Spacing before and after the symbol for each nesting level
    public var levelIndentations: [(pre: CGFloat, past: CGFloat)] = []

    /**
     * Creates a new list
     *
     * - Parameter indentations: Spacing before and after the symbol for each nesting level.
     *                           If not enough indentation levels are provided, the default value `0` will be used for `pre` and `past`.
     */
    public init(indentations: [(pre: CGFloat, past: CGFloat)]) {
        self.levelIndentations = indentations
    }

    /**
     * Adds the given `item` to this list
     *
     * - Parameter item: Item to add
     *
     * - Returns: Reference to this instance, useful for chaining
     */
    @discardableResult public func addItem(_ item: PDFListItem) -> PDFList {
        items.append(item)
        return self
    }

    /**
     * Appends the given `items` to this list
     *
     * - Parameter items: Items to append
     *
     * - Returns: Reference to this instance, useful for chaining
     */
    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFList {
        self.items += items
        return self
    }

    /// Count of items in this list
    public var count: Int {
        items.count
    }

    /**
     * Converts the added instances of ``PDFListItem`` from a nested structure into an array of tuples
     *
     * - Returns: Array of tuples with `level`, `text` and `symbol` for each item
     */
    public func flatted() -> [(level: Int, text: String, symbol: PDFListItemSymbol)] {
        var result: [(level: Int, text: String, symbol: PDFListItemSymbol)] = []
        for (idx, item) in items.enumerated() {
            result += flatItem(item: item, level: 0, index: idx)
        }
        return result
    }

    /**
     * Converts the added instances of ``PDFListItem`` from a nested structure into an array of tuples.
     *
     * - Parameters:
     *     - item: Instance of ``PDFListItem`` to map recursively
     *     - level: Current nesting level, increased during recursive calls
     *     - index: Index in the current level, used with ``PDFListItemSymbol/numbered(value:)``
     *
     * - Returns: Array of tuples with `level`, `text` and `symbol` for each item
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

    /// Removes all items from this list
    func clear() {
        items = []
    }

    // MARK: - Copying

    /// nodoc
    var copy: PDFList {
        let list = PDFList(indentations: levelIndentations)
        list.items = items.map(\.copy)
        return list
    }

    // MARK: - Equatable

    /// nodoc
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherList = other as? PDFList else {
            return false
        }
        guard levelIndentations.count == otherList.levelIndentations.count else {
            return false
        }
        for (idx, indentation) in levelIndentations.enumerated() where otherList.levelIndentations[idx] != indentation {
            return false
        }
        guard items.count == otherList.items.count else {
            return false
        }
        for (idx, item) in items.enumerated() where otherList.items[idx] != item {
            return false
        }
        return true
    }

    // MARK: - Hashable

    /// nodoc
    override public func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        for (pre, post) in levelIndentations {
            hasher.combine(pre)
            hasher.combine(post)
        }
        hasher.combine(items)
    }
}

// MARK: CustomDebugStringConvertible

extension PDFList: CustomDebugStringConvertible {
    /// nodoc
    public var debugDescription: String {
        "PDFList(levels: \(levelIndentations.debugDescription), items: \(items.debugDescription))"
    }
}

// MARK: CustomStringConvertible

extension PDFList: CustomStringConvertible {
    /// nodoc
    public var description: String {
        "PDFList(levels: \(levelIndentations), items: \(items))"
    }
}
