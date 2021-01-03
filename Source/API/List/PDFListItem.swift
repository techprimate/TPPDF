//
//  PDFListItem.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: documentation
 */
public class PDFListItem: PDFDocumentObject {

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

    // MARK: - Equatable

    /// Compares two instances of `PDFListItem` for equality
    ///
    /// - Parameters:
    ///   - lhs: One instance of `PDFListItem`
    ///   - rhs: Another instance of `PDFListItem`
    /// - Returns: `true`, if `attributes`, `tag`, `content`, `children` and `symbol` equal; otherwise `false`
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherListItem = other as? PDFListItem else {
            return false
        }
        guard self.content == otherListItem.content else {
            return false
        }
        guard self.children == otherListItem.children else {
            return false
        }
        guard self.symbol == otherListItem.symbol else {
            return false
        }
        return true
    }

    // MARK: - Equatable

    override public func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(content)
        hasher.combine(children)
        hasher.combine(symbol)
    }
}

extension PDFListItem: CustomDebugStringConvertible {

    public var debugDescription: String {
        let content = self.content ?? "nil"
        let children = self.children?.debugDescription ?? "nil"
        return "PDFListItem(symbol: \(symbol), content: \(content): children: \(children))"
    }
}

extension PDFListItem: CustomStringConvertible {

    public var description: String {
        let content = self.content ?? "nil"
        let children = self.children?.description ?? "nil"
        return "PDFListItem(symbol: \(symbol), content: \(content): children: \(children))"
    }
}
