//
//  PDFImageRowObject.swift
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
 TODO: documentation
 */
internal class PDFImageRowObject: PDFRenderObject {

    /**
     TODO: documentation
     */
    internal var images: [PDFImage]

    /**
     TODO: documentation
     */
    internal var spacing: CGFloat

    /**
     TODO: documentation
     */
    internal var captionSpacing: CGFloat

    /**
     TODO: documentation
     */
    internal init(images: [PDFImage], spacing: CGFloat = 1.0, captionSpacing: CGFloat = 5.0) {
        self.images = images
        self.spacing = spacing
        self.captionSpacing = captionSpacing
    }

    /**
     TODO: documentation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        let originalInsetLeft = generator.layout.indentation.leftIn(container: container)
        let originalInsetRight = generator.layout.indentation.rightIn(container: container)
        var originalHeight = generator.layout.heights.value(for: container)

        var additionInset: CGFloat = 0

        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        let totalSpacing = CGFloat(images.count - 1) * spacing
        let imageWidth = (availableSize.width - totalSpacing) / CGFloat(images.count)

        var maxHeight: CGFloat = 0

        for (idx, image) in images.enumerated() {
            // Ensure the image's width is smaller than the row's width
            let width = min(imageWidth, image.size.width)
            image.size = CGSize(width: width, height: image.size.height * width / image.size.width)
            image.sizeFit = .width

            let imageObject = PDFImageObject(image: image, captionSpacing: captionSpacing)

            generator.layout.indentation.setLeft(indentation: originalInsetLeft + additionInset + spacing * CGFloat(idx),
                                                 in: container)
            generator.layout.indentation.setRight(indentation: originalInsetRight + (imageWidth + spacing) * CGFloat(images.count - idx - 1),
                                                  in: container)

            let res = try imageObject.calculate(generator: generator, container: container)
            if res.contains(where: { $0.1 is PDFPageBreakObject }) {
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

    /**
     TODO: documentation
     */
    override internal var copy: PDFRenderObject {
        PDFImageRowObject(images: self.images, spacing: self.spacing, captionSpacing: self.captionSpacing)
    }
}
