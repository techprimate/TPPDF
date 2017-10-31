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
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        let document = generator.document
        
        let x: CGFloat = document.layout.margin.left + generator.indentation.leftIn(container: container)
        let y: CGFloat = generator.heights.maxHeaderHeight() + document.layout.margin.top + generator.heights.content
        let width = document.layout.size.width - document.layout.margin.left - document.layout.margin.right - generator.indentation.rightIn(container: container)
        
        self.frame = CGRect(x: x, y: y, width: width, height: 0)
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        PDFGraphics.drawLine(
            start: self.frame.origin,
            end: CGPoint(x: self.frame.maxX, y: self.frame.minY),
            style: style
        )
        
        if PDFGenerator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .green)
        }
    }
}
