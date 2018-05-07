//
//  PDFImageRowObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFImageRowObject: PDFObject {

    var images: [PDFImage]
    var spacing: CGFloat
    var captionSpacing: CGFloat

    init(images: [PDFImage], spacing: CGFloat = 1.0, captionSpacing: CGFloat = 5.0) {
        self.images = images
        self.spacing = spacing
        self.captionSpacing = captionSpacing
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        let originalInsetLeft = generator.layout.indentation.leftIn(container: container)
        let originalInsetRight = generator.layout.indentation.rightIn(container: container)

        var additionInset: CGFloat = 0

        var originalHeight = generator.layout.heights.value(for: container)

        let totalImagesWidth = generator.document.layout.contentSize.width
        let totalSpacing = CGFloat(images.count - 1) * spacing
        let imageWidth = (totalImagesWidth - totalSpacing) / CGFloat(images.count)

        var maxHeight: CGFloat = 0

        for (idx, image) in images.enumerated() {
            // Ensure the image's width is smaller than the row's width
            let width = min(imageWidth, image.size.width)
            image.size = CGSize(width: width, height: image.size.height * width / image.size.width)
            image.sizeFit = .width

            let imageObject = PDFImageObject(image: image, captionSpacing: captionSpacing)

            generator.layout.indentation.setLeft(indentation: originalInsetLeft + additionInset + spacing * CGFloat(idx), in: container)
            generator.layout.indentation.setRight(indentation: originalInsetRight
                + (imageWidth + spacing) * CGFloat(images.count - idx - 1), in: container)

            let res = try imageObject.calculate(generator: generator, container: container)
            for obj in res where obj.1 is PDFPageBreakObject {
                originalHeight = 0
            }
            result += res

            maxHeight = max(maxHeight, generator.layout.heights.value(for: container))
            generator.layout.heights.set(originalHeight, to: container)

            additionInset += imageWidth
        }

        generator.layout.heights.set(maxHeight, to: container)

        generator.layout.indentation.setLeft(indentation: originalInsetLeft, in: container)
        generator.layout.indentation.setLeft(indentation: originalInsetRight, in: container)

        return result
    }

    override var copy: PDFObject {
        return PDFImageRowObject(images: self.images, spacing: self.spacing, captionSpacing: self.captionSpacing)
    }
}
