//
//  PDFLineSeparator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFLineSeparatorObject: PDFObject {
    
    var style: PDFLineStyle
    
    init(style: PDFLineStyle = PDFLineStyle()) {
        self.style = style
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let x = generator.document.layout.margin.left
            + generator.layout.indentation.leftIn(container: container)
        let y = generator.layout.heights.maxHeaderHeight()
            + generator.document.layout.margin.top
            + generator.layout.heights.content

        let width = generator.document.layout.contentSize.width
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container)

        self.frame = CGRect(x: x, y: y, width: width, height: 0)

        return [(container, self)]
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        PDFGraphics.drawLine(
            start: self.frame.origin,
            end: CGPoint(x: self.frame.maxX, y: self.frame.maxY),
            style: style
        )
        
        if PDFGenerator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .clear)
        }
    }
}
