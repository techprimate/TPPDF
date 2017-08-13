//
//  PDFSpaceObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFSpaceObject : PDFObject {
    
    var space: CGFloat

    init(space: CGFloat) {
        self.space = space
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        if container.isHeader {
            generator.heights.header[container] = generator.heights.header[container]! + space
        } else if container.isFooter {
            generator.heights.header[container] = generator.heights.footer[container]! + space
        } else {
            generator.heights.content += space
        }
    }
}
    
