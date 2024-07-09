//
//  PDFImageObject.swift
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
 Calculates the given image and a caption if necessary
 */
class PDFImageObject: PDFRenderObject {
    /**
     Image object holding all information
     */
    var image: PDFImage

    /**
     Spacing between image and caption
     */
    var captionSpacing: CGFloat

    /**
     Initializer

     - Parameter image: Image object
     - Parameter captionSpacing: Spacing to caption, defaults to zero
     */
    init(image: PDFImage, captionSpacing: CGFloat = 0) {
        self.image = image
        self.captionSpacing = captionSpacing
    }

    /**
     Calculates the frame of the image and additionally returns one or multiple caption objects.

     - Parameter generator: Current instance handling the calculations
     - Parameter container: Container where the image is placed in

     - Throws: Caption calculation errors, see ```PDFAttributedTextObject.calculate(_:,_:)```

     - Returns: Calculated objects and their corresponding container, created by this calculation
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        var (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(generator: generator,
                                                                                 container: container,
                                                                                 image: image,
                                                                                 size: image.size,
                                                                                 sizeFit: image.sizeFit)
        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        if container.isCenter {
            let isAvailableHeightZero = availableSize.height == 0
            let isImageCaptionHeightCombinedTooSmall = imageSize.height + captionSize.height > availableSize.height
            let isImageHeightTooSmall = image.sizeFit == .height && imageSize.height < image.size.height
            if isAvailableHeightZero || isImageCaptionHeightCombinedTooSmall || isImageHeightTooSmall {
                result += try PDFPageBreakObject().calculate(generator: generator, container: container)
                generator.layout.heights.content = 0

                (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(
                    generator: generator,
                    container: container,
                    image: image,
                    size: image.size,
                    sizeFit: image.sizeFit
                )
            }
        }
        let position = PDFCalculations.calculateElementPosition(for: generator, in: container, with: imageSize)
        frame = CGRect(origin: position, size: imageSize)
        updateHeights(generator: generator, container: container)

        result.append((container, self))

        for attribute in image.attributes {
            attributes.append((attribute: attribute, frame: frame))
        }

        if let caption = image.caption {
            result += try PDFAttributedTextObject(text: caption).calculate(generator: generator, container: PDFContainer.contentCenter)
        }
        return result
    }

    /**
     Modifies the image and draws it in the previously calculated frame

     - Parameter generator: Current instance handling the drawing
     - Parameter container: Container where the image is placed in
     */
    override func draw(generator _: PDFGenerator, container _: PDFContainer, in context: PDFContext) throws {
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
        #if os(iOS) || os(visionOS)
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

     - Parameter generator: Current instance handling the calculations
     - Parameter container: Container where the image is placed in
     */
    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        generator.layout.heights.add(frame.height + (image.caption != nil ? captionSpacing : 0), to: container)
    }

    /**
     Creates a new `PDFImageObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFImageObject(image: image.copy, captionSpacing: captionSpacing)
    }
}
