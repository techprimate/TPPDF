//
//  PDFImageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Calculates the given image and a caption if necessary
 */
class PDFImageObject: PDFObject {

    /**
     Image object holding all information
     */
    var image: PDFImage

    /**
     Spacing between image and caption
     */
    var captionSpacing: CGFloat

    /**
     Initalizer

     - parameter image: Image object
     */
    init(image: PDFImage, captionSpacing: CGFloat = 0) {
        self.image = image
        self.captionSpacing = captionSpacing
    }

    /**
     Calculates the frame of the image and additionally returns one or multiple caption objects.
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        var (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(generator: generator,
                                                                           container: container,
                                                                           image: image,
                                                                           size: image.size,
                                                                           sizeFit: image.sizeFit)

        if container.isCenter {
            if generator.layout.heights.content + imageSize.height + captionSize.height > generator.document.layout.contentSize.height ||
                (image.sizeFit == .height && imageSize.height < image.size.height) {

                result += [(container, PDFPageBreakObject())]
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

        if let caption = image.caption {
            result += try PDFAttributedTextObject(text: caption).calculate(generator: generator, container: PDFContainer.contentCenter)
        }
        return result
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        var roundedCorners: UIRectCorner = []
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
        modifiedImage.draw(in: self.frame)
    }

    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        generator.layout.heights.add(frame.height + (self.image.caption != nil ? captionSpacing : 0), to: container)
    }

    override var copy: PDFObject {
        return PDFImageObject(image: self.image.copy, captionSpacing: self.captionSpacing)
    }
}
