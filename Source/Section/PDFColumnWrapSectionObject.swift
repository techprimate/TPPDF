//
//  PDFColumnWrapSectionObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

class PDFColumnWrapSectionObject: PDFObject {

    var columns: Int
    var widths: [CGFloat]
    var spacings: [CGFloat]
    var isDisable: Bool

    init(columns: Int, widths: [CGFloat], spacings: [CGFloat], isDisable: Bool) {
        self.columns = columns
        self.widths = widths
        self.spacings = spacings
        self.isDisable = isDisable
    }

    /**
     Modifies the layout of the given `generator`.

     - parameter generator: Generator which uses this object
     - parameter container: Container where this object is located

     - returns: Self
     */
    @discardableResult
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        if isDisable {
            generator.maxColumns = nil
            generator.currentColumn = 0
            generator.columnWidths = []

            let leftInsetObjects = try PDFIndentationObject(indentation: 0, left: false).calculate(generator: generator, container: container)
            let rightInsetObjects = try PDFIndentationObject(indentation: 0, left: true).calculate(generator: generator, container: container)
            let pageBreakObjects = try PDFPageBreakObject().calculate(generator: generator, container: container)

            return leftInsetObjects + rightInsetObjects + pageBreakObjects
        } else {
            generator.wrapColumnsHeight = generator.layout.heights.content
            generator.maxColumns = columns
            generator.currentColumn = 0
            generator.columnSpacings = spacings

            var availableWidth = PDFCalculations.calculateAvailableFrame(for: generator, in: container).width
            let totalSpacing = spacings.reduce(0, +)
            availableWidth -= totalSpacing
            generator.columnWidths = widths.map { return $0 * availableWidth }

            if generator.columnWidths.isEmpty {
                generator.columnWidths = [availableWidth]
            }

            let inset = PDFCalculations.calculateColumnWrapInset(generator: generator)
            let spacing = PDFCalculations.calculateColumnWrapSpacing(generator: generator)

            let lefInsetObjects = try PDFIndentationObject(indentation: inset.left + spacing.left, left: false)
                .calculate(generator: generator, container: container)
            let rightInsetObjects = try PDFIndentationObject(indentation: inset.right + spacing.right, left: false)
                .calculate(generator: generator, container: container)

            return [(container, self)] + lefInsetObjects + rightInsetObjects
        }
    }

    override var copy: PDFObject {
        return PDFColumnWrapSectionObject(columns: self.columns, widths: self.widths, spacings: self.spacings, isDisable: self.isDisable)
    }
}
