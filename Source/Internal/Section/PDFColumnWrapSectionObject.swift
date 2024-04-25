//
//  PDFColumnWrapSectionObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

class PDFColumnWrapSectionObject: PDFRenderObject {
    var columns: Int
    var widths: [CGFloat]
    var spacings: [CGFloat]
    var isDisable: Bool
    var addPageBreak: Bool

    convenience init(columns: Int, widths: [CGFloat], spacings: [CGFloat]) {
        self.init(columns: columns, widths: widths, spacings: spacings, isDisable: false, addPageBreak: false)
    }

    convenience init(isDisable: Bool, addPageBreak: Bool) {
        self.init(columns: 0, widths: [], spacings: [], isDisable: isDisable, addPageBreak: addPageBreak)
    }

    init(columns: Int, widths: [CGFloat], spacings: [CGFloat], isDisable: Bool, addPageBreak: Bool) {
        self.columns = columns
        self.widths = widths
        self.spacings = spacings
        self.isDisable = isDisable
        self.addPageBreak = addPageBreak
    }

    /**
     Modifies the layout of the given `generator`.

     - Parameter generator: Generator which uses this object
     - Parameter container: Container where this object is located

     - Returns: Self
     */
    @discardableResult
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.columnState.set(currentColumn: 0, for: container)
        generator.columnState.set(inset: (0, 0), for: container)

        if isDisable {
            generator.columnState.set(maxColumns: nil, for: container)
            generator.columnState.set(columnWidths: [], for: container)

            return addPageBreak ? try PDFPageBreakObject().calculate(generator: generator, container: container) : []
        }

        generator.columnState.set(wrapColumnsHeight: generator.layout.heights.content, for: container)
        generator.columnState.set(maxColumns: columns, for: container)
        generator.columnState.set(columnSpacings: spacings, for: container)

        var availableWidth = PDFCalculations.calculateAvailableFrame(for: generator, in: container).width
        availableWidth -= spacings.reduce(0, +)
        generator.columnState.set(columnWidths: widths.map { $0 * availableWidth }, for: container)

        if generator.columnState.getColumnWidths(for: container).isEmpty {
            generator.columnState.set(columnWidths: [availableWidth], for: container)
        }

        let inset = PDFCalculations.calculateColumnWrapInset(generator: generator, container: container)
        let spacing = PDFCalculations.calculateColumnWrapSpacing(generator: generator, container: container)

        generator.columnState.set(inset: (left: inset.left + spacing.left,
                                          right: inset.right + spacing.right), for: container)

        return [(container, self)]
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFColumnWrapSectionObject(
            columns: columns,
            widths: widths,
            spacings: spacings,
            isDisable: isDisable,
            addPageBreak: addPageBreak
        )
    }
}
