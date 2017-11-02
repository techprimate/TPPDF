//
//  PDFImageRowObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFImageRowObject: PDFObject {
    
    var images: [PDFImage]
    var spacing: CGFloat

    init(images: [PDFImage], spacing: CGFloat = 1.0) {
        self.images = images
        self.spacing = spacing
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        let totalImagesWidth = generator.document.layout.contentSize.width
        let imageWidth = totalImagesWidth / CGFloat(images.count)

        for image in images {
            let imageObject = PDFImageObject(image: image)
            result += try imageObject.calculate(generator: generator, container: container)
        }

        return result
    }
}
