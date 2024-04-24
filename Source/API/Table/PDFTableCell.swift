//
//  PDFTableCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/// An instance of a table cell
public class PDFTableCell: PDFDocumentObject {
    /**
     * Content of this cell, can be different kinds of data inside a `PDFTableContent` object.
     *
     * Might be `nil`, meaning the cell can be empty.
     */
    public var content: PDFTableContent?

    /// Custom style of this particular cell
    public var style: PDFTableCellStyle?

    /// Alignment of content inside cell
    public var alignment: PDFTableCellAlignment

    /**
     * Creates a new cell with the optionally given content, alignment and style.
     *
     * If none are given, see defaults.
     *
     * - Parameter content: ``PDFTableContent`` holding different kinds of data, defaults to `nil`, meaning the cell is empty
     * - Parameter alignment: ``PDFTableCellAignment`` setting the alignment position of the conten
     * - Parameter style: ``PDFTableCelStyle`` for overwriting table wide styling for this particular cell
     */
    public init(content: PDFTableContent? = nil, alignment: PDFTableCellAlignment = .center, style: PDFTableCellStyle? = nil) {
        self.content = content
        self.alignment = alignment
        self.style = style
    }

    // MARK: - Equatable

    /// nodoc
    override public func isEqual(to other: PDFDocumentObject) -> Bool {
        guard super.isEqual(to: other) else {
            return false
        }
        guard let otherCell = other as? PDFTableCell else {
            return false
        }
        guard content == otherCell.content else {
            return false
        }
        guard style == otherCell.style else {
            return false
        }
        guard alignment == otherCell.alignment else {
            return false
        }
        return true
    }

    // MARK: - Equatable

    /// nodoc
    override public func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        hasher.combine(content)
        hasher.combine(style)
        hasher.combine(alignment)
    }
}
