//
//  PDFSection.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * A multi-column section is a nested container.
 *
 * Creating the section with an amount of columns and their relative width, add objects to each column and then add the whole section to the document.
 *
 * When adding an object to the section column, you use the Array subscript `section.columns[0]`.
 * You are able to give it an alignment as the first parameter, similar to the `PDFContainer` but only with `.left`, `.center` and `.right`
 * as it is not possible to add a section to the header or footer containers.
 *
 * Use ``PDFDocument/enable(_:columns:widths:spacings:)``for details on how  to enable multi-columns with automatic text wrapping,
 * allowing to split a page into multiple columns and fill it up starting at the left.
 *
 * **Example:**
 * ```swift
 * let section = PDFSection(columnWidths: [0.3, 0.4, 0.3])
 * section.columns[0].addText(.right, text: "right")
 * section.columns[1].addText(.left, text: "left")
 * section.columns[2].addText(.center, text: "center")
 * document.add(section: section)
 * ```
 *
 * **Attention:**
 *
 * Do not add a ``PDFSection`` multiple times to a ``PDFDocument``, as they hold some internal state, which will lead to collisions and unpredictable
 * framing calculations.
 */
public class PDFSection: PDFDocumentObject {
    /// List of section columns.
    public private(set) var columns: [PDFSectionColumn] = []

    /// Horizontal margin between columns in points.
    public var columnMargin: CGFloat = 10.0

    // MARK: - PUBLIC INITIALIZERS

    /**
     * Creates a new section with columns of the given relative widths.
     *
     * - Parameter columnWidth: Relative column widths. Values are between 0.0 and 1.0 and should sum up to 1.0.
     */
    public convenience init(columnWidths: [CGFloat]) {
        self.init(columnWidths.map(PDFSectionColumn.init(width:)))
    }

    /**
     * Creates a new section with the given columns.
     *
     * - Parameter columns: Preconfigured section columns
     */
    public init(_ columns: [PDFSectionColumn]) {
        self.columns = columns
    }

    /// nodoc
    var copy: PDFSection {
        PDFSection(columns.map(\.copy))
    }
}
