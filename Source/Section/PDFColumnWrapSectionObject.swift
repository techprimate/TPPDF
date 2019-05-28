//
//  PDFColumnWrapSectionObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

class PDFColumnWrapSectionObject: PDFObject {

    var columns: Int
    var isDisable: Bool

    init(columns: Int, isDisable: Bool) {
        self.columns = columns
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
            generator.columnWidth = 0

            let leftInsetObjects = try PDFIndentationObject(indentation: 0, left: false).calculate(generator: generator, container: container)
            let rightInsetObjects = try PDFIndentationObject(indentation: 0, left: true).calculate(generator: generator, container: container)
            let pageBreakObjects = try PDFPageBreakObject().calculate(generator: generator, container: container)

            return leftInsetObjects + rightInsetObjects + pageBreakObjects
        } else {
            generator.maxColumns = columns
            generator.currentColumn = 1

            let availableWidth = PDFCalculations.calculateAvailableFrame(for: generator, in: container).width
            generator.columnWidth = availableWidth / CGFloat(columns)

            let insetObjects = try PDFIndentationObject(indentation: CGFloat(columns - 1) * generator.columnWidth,
                                                        left: false).calculate(generator: generator, container: container)

            return [(container, self)] + insetObjects
        }
    }

    override var copy: PDFObject {
        return PDFColumnWrapSectionObject(columns: self.columns, isDisable: self.isDisable)
    }
}
