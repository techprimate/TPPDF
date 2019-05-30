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

    private var stayOnSamePage: Bool = false

    /**
     Modifies the layout and page count of the given `generator`.
     The parameter `container` is unused, as page breaks are container-independent.

     - parameter generator: Generator which uses this object
     - parameter container: Unused

     - throws: None

     - returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        generator.layout.heights.content = generator.wrapColumnsHeight

        stayOnSamePage = false

        var result: [(PDFContainer, PDFObject)] = [(container, self)]
        if let maxColumns = generator.maxColumns {
            generator.currentColumn += 1

            if generator.currentColumn >= maxColumns {
                generator.wrapColumnsHeight = 0
                generator.layout.heights.content = 0
            }
            if generator.currentColumn < maxColumns {
                stayOnSamePage = true
            } else {
                generator.currentColumn = 0
            }

            let inset = PDFCalculations.calculateColumnWrapInset(generator: generator)
            let spacing = PDFCalculations.calculateColumnWrapSpacing(generator: generator)

            result += try PDFIndentationObject(indentation: inset.left + spacing.left, left: true)
                .calculate(generator: generator, container: container)
            result += try PDFIndentationObject(indentation: inset.right + spacing.right, left: false)
                .calculate(generator: generator, container: container)
        }

        return result
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
