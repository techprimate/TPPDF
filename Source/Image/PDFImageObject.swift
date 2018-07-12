//
//  PDFImageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

// swiftlint:disable function_body_length

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

        let y: CGFloat = {
            if container.isHeader {
                return generator.document.layout.margin.top
                    + generator.layout.heights.header[container]!
            } else if container.isFooter {
                return generator.document.layout.contentSize.height
                    + generator.document.layout.margin.top
                    + generator.layout.heights.maxHeaderHeight()
                    + generator.layout.heights.footer[container]!
            } else {
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
                return generator.document.layout.margin.top
                    + generator.layout.heights.maxHeaderHeight()
                    + generator.document.layout.space.header
                    + generator.layout.heights.content
            }
            }()

        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return generator.document.layout.margin.left
                    + generator.layout.indentation.leftIn(container: container)
            case .headerCenter, .contentCenter, .footerCenter:
                return generator.document.layout.margin.left
					+ generator.layout.indentation.leftIn(container: container)
                    + (generator.document.layout.contentSize.width
                        - generator.layout.indentation.leftIn(container: container)
                        - generator.layout.indentation.rightIn(container: container)
                        ) / 2
                    - imageSize.width / 2
            case .headerRight, .contentRight, .footerRight:
                return generator.document.layout.width
                    - generator.document.layout.margin.right
                    - generator.layout.indentation.rightIn(container: container)
                    - imageSize.width
            default:
                return 0
            }
        }()

        self.frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)

        updateHeights(generator: generator, container: container)

        result.append((container, self))

        if let caption = image.caption {
            let text = PDFAttributedTextObject(text: caption)
            result += try text.calculate(generator: generator, container: PDFContainer.contentCenter)
        }

        return result
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        PDFGraphics.resizeAndCompressImage(image: image.image,
                                           frame: frame,
                                           shouldResize: image.options.contains(.resize),
                                           shouldCompress: image.options.contains(.compress),
                                           quality: image.quality).draw(in: self.frame)
    }

    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        generator.layout.heights.add(frame.height + (self.image.caption != nil ? captionSpacing : 0), to: container)
    }

    override var copy: PDFObject {
        return PDFImageObject(image: self.image.copy, captionSpacing: self.captionSpacing)
    }
}
