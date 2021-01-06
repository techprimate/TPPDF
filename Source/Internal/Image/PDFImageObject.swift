//
//  PDFImageObject.swift
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
 Calculates the given image and a caption if necessary
 */
internal class PDFImageObject: PDFRenderObject {

    /**
     Image object holding all information
     */
    internal var image: PDFImage

    /**
     Spacing between image and caption
     */
    internal var captionSpacing: CGFloat

    /**
     Initalizer

     - parameter image: Image object
     - parameter captionSpacing: Spacing to caption, defaults to zero
     */
    internal init(image: PDFImage, captionSpacing: CGFloat = 0) {
        self.image = image
        self.captionSpacing = captionSpacing
    }

    /**
     Calculates the frame of the image and additionally returns one or multiple caption objects.

     - parameter generator: Current instance handling the calculations
     - parameter container: Container where the image is placed in

     - throws: Caption calculation errors, see ```PDFAttributedTextObject.calculate(_:,_:)```

     - returns: Calculated objects and their corresponding container, created by this calculation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        var (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(generator: generator,
                                                                                 container: container,
                                                                                 image: image,
                                                                                 size: image.size,
                                                                                 sizeFit: image.sizeFit)
        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        if container.isCenter {
            if imageSize.height + captionSize.height > availableSize.height || (image.sizeFit == .height && imageSize.height < image.size.height) {
                result += try PDFPageBreakObject().calculate(generator: generator, container: container)
                generator.layout.heights.content = 0

                (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(
                    generator: generator,
                    container: container,
                    image: image,
                    size: image.size,
                    sizeFit: image.sizeFit)
            }
        }
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: imageSize)
        self.frame = CGRect(origin: position, size: imageSize)
        updateHeights(generator: generator, container: container)

        result.append((container, self))

        for attribute in image.attributes {
            self.attributes.append((attribute: attribute, frame: self.frame))
        }

        if let caption = image.caption {
            result += try PDFAttributedTextObject(text: caption).calculate(generator: generator, container: PDFContainer.contentCenter)
        }
        return result
    }

    /**
     Modifies the image and draws it in the previously calculated frame

     - parameter generator: Current instance handling the drawing
     - parameter container: Container where the image is placed in
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        var roundedCorners: RectCorner = []
        if image.options.contains(.rounded) {
            roundedCorners = .allCorners
        } else {
            if image.options.contains(.roundedTopLeft) {
                roundedCorners.formUnion(.topLeft)
            }
            if image.options.contains(.roundedTopRight) {
                roundedCorners.formUnion(.topRight)
            }
            if image.options.contains(.roundedBottomRight) {
                roundedCorners.formUnion(.bottomRight)
            }
            if image.options.contains(.roundedBottomLeft) {
                roundedCorners.formUnion(.bottomLeft)
            }
        }

        let modifiedImage = PDFGraphics.resizeAndCompressImage(image: image.image,
                                                               frame: frame,
                                                               shouldResize: image.options.contains(.resize),
                                                               shouldCompress: image.options.contains(.compress),
                                                               quality: image.quality,
                                                               roundCorners: roundedCorners,
                                                               cornerRadius: image.cornerRadius)

        let cgImage: CGImage?
        #if os(iOS)
        cgImage = modifiedImage.cgImage
        #elseif os(macOS)
        cgImage = modifiedImage.cgImage(forProposedRect: nil, context: nil, hints: nil)
        #endif
        if let cgImage = cgImage {
            context.draw(image: cgImage, in: frame, flipped: true)
        }

        applyAttributes(in: context)
    }

    /**
     Adds the image and caption height to the content height

     - parameter generator: Current instance handling the calculations
     - parameter container: Container where the image is placed in
     */
    internal func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        generator.layout.heights.add(frame.height + (self.image.caption != nil ? captionSpacing : 0), to: container)
    }

    /**
     Creates a new `PDFImageObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFImageObject(image: self.image.copy, captionSpacing: self.captionSpacing)
    }
}
