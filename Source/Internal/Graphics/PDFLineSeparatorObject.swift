//
//  PDFLineSeparatorObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 Calculates and draws a horizontal separator line.

 Separator line is drawn between left and right indentation.
 */
class PDFLineSeparatorObject: PDFRenderObject {
    /// Defines the style of the separator line
    var style: PDFLineStyle

    /**
     Initializer

     - Parameter style: Style of line, defaults to `PDFLineStyle` defaults
     */
    init(style: PDFLineStyle = PDFLineStyle()) {
        self.style = style
    }

    /// nodoc
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let width = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: container)
        let size = CGSize(width: width, height: style.width)
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: size)
        frame = CGRect(origin: position, size: size)

        return [(container, self)]
    }

    /// nodoc
    override func draw(generator: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
        PDFGraphics.drawLine(
            in: context,
            start: CGPoint(x: frame.minX, y: frame.midY),
            end: CGPoint(x: frame.maxX, y: frame.midY),
            style: style
        )

        if generator.debug && (style.type == .none) {
            PDFGraphics.drawRect(in: context,
                                 rect: frame,
                                 outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .clear)
        }

        applyAttributes(in: context)
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFLineSeparatorObject(style: style)
    }
}
