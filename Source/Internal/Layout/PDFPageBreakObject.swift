//
//  PDFPageBreakObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif
import CoreGraphics

/// Used in the rendering to create a new page
class PDFPageBreakObject: PDFRenderObject {
    var stayOnSamePage: Bool = false

    /**
     Modifies the layout and page count of the given `generator`.
     The parameter `container` is unused, as page breaks are container-independent.

     - Parameter generator: Generator which uses this object
     - Parameter container: Unused

     - Throws: None

     - Returns: Self
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        generator.layout.heights.content = generator.columnState.getWrapColumnsHeight(for: container)

        stayOnSamePage = false

        if let maxColumns = generator.columnState.getMaxColumns(for: container) {
            let currentColumn = generator.columnState.getCurrentColumn(for: container)
            generator.columnState.set(currentColumn: currentColumn + 1, for: container)

            if generator.columnState.getCurrentColumn(for: container) >= maxColumns {
                generator.columnState.set(wrapColumnsHeight: 0, for: container)
                generator.layout.heights.set(0, to: container)
            }
            if generator.columnState.getCurrentColumn(for: container) < maxColumns {
                stayOnSamePage = true
            } else {
                generator.columnState.set(currentColumn: 0, for: container)
            }

            let inset = PDFCalculations.calculateColumnWrapInset(generator: generator, container: container)
            let spacing = PDFCalculations.calculateColumnWrapSpacing(generator: generator, container: container)

            generator.columnState.set(inset: (left: inset.left + spacing.left, right: inset.right + spacing.right), for: container)
        }

        return [(container, self)]
    }

    /**
     Creates a new page in the PDF context.
     Draws debug page overlay on newly created page

     - Parameter generator: Generator which uses this object
     - Parameter container: Unused

     - Throws: None
     */
    override func draw(generator: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        if !stayOnSamePage {
            PDFContextGraphics.endPDFPage(in: context)
            PDFContextGraphics.beginPDFPage(in: context, for: generator.document.layout.bounds)
            // if there is a background color set, fill the page with it
            if let color = generator.document.background.color {
                PDFGraphics.drawRect(in: context, rect: generator.document.layout.bounds, outline: .none, fill: color)
            }
            generator.drawDebugPageOverlay(in: context)
        }
        applyAttributes(in: context)
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFPageBreakObject()
    }
}
