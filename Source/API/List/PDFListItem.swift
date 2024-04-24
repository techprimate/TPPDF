//
//  PDFListItem.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 * An item used in a ``PDFList``
 *
 * By configuring the ``PDFListItem/symbol`` it is possible to mix the symbols used by list items.
 *
 * ```swift
 * let document = PDFDocument(format: .a4)
 *
 * let items = [
 *     "Simple text drawing",
 *     "Advanced text drawing using AttributedString",
 *     "Multi-layer rendering by simply setting the offset",
 *     "Fully calculated content sizing",
 *     "Automatic page wrapping",
 *     "Customizable pagination",
 *     "Fully editable header and footer",
 *     "Simple image positioning and rendering",
 *     "Image captions"
 * ]
 *
 * // Simple bullet point list
 * let featureList = PDFList(indentations: [
 *     (pre: 10.0, past: 20.0),
 *     (pre: 20.0, past: 20.0),
 *     (pre: 40.0, past: 20.0)
 * ])
 *
 * // By adding the item first to a list item with the dot symbol, all of them will inherit it
 * featureList
 *     .addItem(PDFListItem(symbol: .dot)
 *     .addItems(items.map { PDFListItem(content: $0) })
 * document.add(list: featureList)
 *
 * document.add(space: 20)
 *
 * // Numbered list with unusual indentation
 * let weirdIndentationList = PDFList(indentations: [
 *     (pre: 10.0, past: 20.0),
 *     (pre: 40.0, past: 30.0),
 *     (pre: 20.0, past: 50.0)
 * ])
 *
 * weirdIndentationList.addItems(items.enumerated().map { arg in
 *     PDFListItem(symbol: .numbered(value: "\(arg.offset + 1)"), content: arg.element)
 * })
 * document.add(list: weirdIndentationList)
 * ```
 */
public class PDFListItem: PDFDocumentObject {
    /// Weak reference to the parent list item, used to implement the list symbol ``PDFListItemSymbol/inherit``
    public weak var parent: PDFListItem?

    /// Text content of this list item, calculated and rendered using ``PDFSimpleText``
    public var content: String?

    /// List of ``PDFListItem`` nested in this instance
    public var children: [PDFListItem]?

    /// Symbol used for this list item
    public var symbol: PDFListItemSymbol

    /**
     * Creates a new list item
     *
     * - Parameter symbol: See ``PDFListItem/symbol`` for details, defaults to ``PDFListItemSymbol/inherit``
     * - Parameter content: See ``PDFListItem/content``, defaults to `nil`
     */
    public init(
        symbol: PDFListItemSymbol = PDFListItemSymbol.inherit,
        content: String? = nil
    ) {
        self.symbol = symbol
        self.content = content
    }

    /**
     * Appends the given `items` to the list of nested items
     *
     * - Parameter items: Items to append
     *
     * - Returns: Reference to this instance, useful for chaining
     */
    @discardableResult public func addItems(_ items: [PDFListItem]) -> PDFListItem {
        for item in items {
            _ = addItem(item)
        }

        return self
    }

    /**
     * Adds the given `item` to the list of nested items
     *
     * - Parameter item: Item to add
     *
     * - Returns: Reference to this instance, useful for chaining
     */
    @discardableResult public func addItem(_ item: PDFListItem) -> PDFListItem {
        item.parent = self
        children = (children ?? []) + [item]

        return self
    }

    /**
     * Sets the content of this list item
     *
     * - Parameter content: See ``PDFListItem/content`` for details
     *
     * - Returns: Reference to this instance, useful for chaining
     */
    @discardableResult public func setContent(_ content: String) -> PDFListItem {
        self.content = content

        return self
    }

    // MARK: - Copying

    /// nodoc
    public var copy: PDFListItem {
        let item = PDFListItem(symbol: symbol, content: content)
        for child in children ?? [] {
            item.addItem(child.copy)
        }
        return item
    }

    // MARK: - Equatable

    /// nodoc
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherListItem = other as? PDFListItem else {
            return false
        }
        guard content == otherListItem.content else {
            return false
        }
        guard children == otherListItem.children else {
            return false
        }
        guard symbol == otherListItem.symbol else {
            return false
        }
        return true
    }

    // MARK: - Equatable

    /// nodoc
    override public func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(content)
        hasher.combine(children)
        hasher.combine(symbol)
    }
}

// MARK: CustomDebugStringConvertible

extension PDFListItem: CustomDebugStringConvertible {
    /// nodoc
    public var debugDescription: String {
        let content = self.content ?? "nil"
        let children = self.children?.debugDescription ?? "nil"
        return "PDFListItem(symbol: \(symbol), content: \(content): children: \(children))"
    }
}

// MARK: CustomStringConvertible

extension PDFListItem: CustomStringConvertible {
    /// nodoc
    public var description: String {
        let content = self.content ?? "nil"
        let children = self.children?.description ?? "nil"
        return "PDFListItem(symbol: \(symbol), content: \(content): children: \(children))"
    }
}
