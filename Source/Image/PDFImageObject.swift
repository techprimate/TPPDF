//
//  PDFImageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFImageObject: PDFObject {
    
    var image: PDFImage
    
    init(image: PDFImage) {
        self.image = image
    }
    
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
                    generator.layout.reset()
                    
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
            result += try text.calculate(generator: generator, container: container)
        }
        
        return result
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        let compressedImage = PDFGraphics.resizeAndCompressImage(image: image.image, frame: frame, quality: image.quality)
        compressedImage.draw(in: self.frame)
    }
    
    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        if container.isHeader {
            generator.layout.heights.header[container] = generator.layout.heights.header[container]! + image.size.height
        } else if container.isFooter {
            generator.layout.heights.footer[container] = generator.layout.heights.footer[container]! + image.size.height
        } else {
            generator.layout.heights.content += image.size.height
        }
    }
}
