//
//  PDFLineSeparator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Calculates and draws a horizontal separator line.

 Separator line is drawn between left and right indentation.
 */
internal class PDFLineSeparatorObject: PDFRenderObject {

    /**
     Defines the style of the separator line
     */
    internal var style: PDFLineStyle

    /**
     Initializer

     - parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    internal init(style: PDFLineStyle = PDFLineStyle()) {
        self.style = style
    }

    /**
     Calculates the line start and end point

     - parameter generator: Generator which uses this object
     - parameter container: Container where the line is set

     - throws: None

     - returns: Self
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let width = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: container)
        let size = CGSize(width: width, height: style.width)
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: size)
        self.frame = CGRect(origin: position, size: size)

        return [(container, self)]
    }

    /**
     Draws the line in the calculated frame

     - parameter generator: Unused
     - parameter container: unused

     - throws: None
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawLine(
            in: context,
            start: CGPoint(x: self.frame.minX, y: self.frame.midY),
            end: CGPoint(x: self.frame.maxX, y: self.frame.midY),
            style: style
        )

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(in: context,
                                 rect: self.frame,
                                 outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .clear)
        }

        applyAttributes(in: context)
    }

    /**
     TODO: Documentation
     */
    override internal var copy: PDFRenderObject {
        PDFLineSeparatorObject(style: self.style)
    }
}
