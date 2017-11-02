//
//  PDFSpaceObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFSpaceObject: PDFObject {
    
    var space: CGFloat

    init(space: CGFloat) {
        self.space = space
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        let document = generator.document
        
        let x = document.layout.margin.left
            + generator.layout.indentation.leftIn(container: container)
        
        let y = document.layout.margin.bottom
            + generator.layout.heights.maxHeaderHeight()
            + document.layout.space.header
            + generator.layout.heights.content
        
        let width = document.layout.size.width
            - document.layout.margin.left
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container)
            - document.layout.margin.right
        
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
            generator.layout.heights.header[container] = generator.layout.heights.header[container]! + space
        } else if container.isFooter {
            generator.layout.heights.header[container] = generator.layout.heights.footer[container]! + space
        } else {
            generator.layout.heights.content += space
        }
    }
}
    
