//
//  PDFPageBreakObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Used in the rendering to create a new page
 */
class PDFPageBreakObject: PDFObject {

    /**
     TODO: Documentation
     */
    var stayOnSamePage: Bool = false

    /**
     Modifies the layout and page count of the given `generator`.
     The parameter `container` is unused, as page breaks are container-independent.

     - parameter generator: Generator which uses this object
     - parameter container: Unused

     - throws: None

     - returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.layout.heights.content = generator.columnState.wrapColumnsHeight

        stayOnSamePage = false

        if let maxColumns = generator.columnState.maxColumns {
            generator.columnState.currentColumn += 1

            if generator.columnState.currentColumn >= maxColumns {
                generator.columnState.wrapColumnsHeight = 0
                generator.layout.heights.content = 0
            }
            if generator.columnState.currentColumn < maxColumns {
                stayOnSamePage = true
            } else {
                generator.columnState.currentColumn = 0
            }

            let inset = PDFCalculations.calculateColumnWrapInset(generator: generator)
            let spacing = PDFCalculations.calculateColumnWrapSpacing(generator: generator)

            generator.columnState.inset = (left: inset.left + spacing.left, right: inset.right + spacing.right)
        }

        return [(container, self)]
    }

    /**
     Creates a new page in the PDF context.
     Draws debug page overlay on newly created page

     - parameter generator: Generator which uses this object
     - parameter container: Unused

     - throws: None
     */
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        if !stayOnSamePage {
            UIGraphicsBeginPDFPage()
            generator.drawDebugPageOverlay()
        }
    }

    /**
     Creates a new `PDFPageBreakObject`
     */
    override var copy: PDFObject {
        return PDFPageBreakObject()
    }
}

extension PDFPageBreakObject: CustomDebugStringConvertible {

    var debugDescription: String {
        return "PDFPageBreakObject(frame: \(self.frame))"
    }
}

extension PDFPageBreakObject: CustomStringConvertible {

    var description: String {
        return "PDFPageBreakObject(frame: \(self.frame))"
    }
}
