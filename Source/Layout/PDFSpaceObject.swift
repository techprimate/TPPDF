//
//  PDFSpaceObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFSpaceObject: PDFObject {
    
    var space: CGFloat

    init(space: CGFloat) {
        self.space = space
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let document = generator.document
        
        let x: CGFloat = document.layout.margin.left
            + generator.indentation.leftIn(container: container)
        let y: CGFloat = document.layout.margin.bottom
            + generator.heights.maxHeaderHeight()
            + document.layout.space.header
            + generator.heights.content
        
        let width = document.layout.size.width
            - document.layout.margin.left
            - document.layout.margin.right
            - generator.indentation.leftIn(container: container)
            - generator.indentation.rightIn(container: container)
        
        self.frame = CGRect(x: x, y: y, width: width, height: space)
        
        updateHeights(generator: generator, container: container)
        
        return [(container, self)]
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        if PDFGenerator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .green)
        }
    }
    
    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        if container.isHeader {
            generator.heights.header[container] = generator.heights.header[container]! + space
        } else if container.isFooter {
            generator.heights.header[container] = generator.heights.footer[container]! + space
        } else {
            generator.heights.content += space
        }
    }
}
    
