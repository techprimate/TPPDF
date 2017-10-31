//
//  PDFImageObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
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
                                                                           image: image.image,
                                                                           caption: image.caption,
                                                                           size: image.size,
                                                                           sizeFit: image.sizeFit)
        
        let y: CGFloat = try {
            switch container.normalize {
            case .headerLeft:
                return generator.heights.header[container]!
            case .contentLeft:
                if generator.heights.content + imageSize.height + captionSize.height > generator.document.layout.contentSize.height ||
                    (image.sizeFit == .height && imageSize.height < image.size.height) {
                    
                    result += [(container, PDFPageBreakObject())]
                    
                    (imageSize, captionSize) = PDFCalculations.calculateImageCaptionSize(generator: generator,
                                                                                   container: container,
                                                                                   image: image.image,
                                                                                   caption: image.caption,
                                                                                   size: image.size,
                                                                                   sizeFit: image.sizeFit)
                }
                return generator.maxHeaderHeight() + generator.document.layout.space.header + generator.heights.content
            case .footerLeft:
                return generator.document.layout.contentSize.height + generator.maxHeaderHeight() + generator.heights.header[container]!
            default:
                return 0
            }
            }()
        
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return generator.document.layout.margin.left + generator.indentation.leftIn(container: container)
            case .headerCenter, .contentCenter, .footerCenter:
                return generator.document.layout.bounds.midX - imageSize.width / 2
            case .headerRight, .contentRight, .footerRight:
                return generator.document.layout.bounds.width - generator.document.layout.margin.left - imageSize.width
            default:
                return 0
            }
        }()
        
        self.frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
        
        return [
            (container, self)
        ]
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        let compressedImage = PDFGraphics.resizeAndCompressImage(image: image.image, frame: frame, quality: image.quality)
        compressedImage.draw(in: self.frame)
    }
    
    override func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        if container.isHeader {
            generator.heights.header[container] = generator.heights.header[container]! + image.size.height
        } else if container.isFooter {
            generator.heights.footer[container] = generator.heights.footer[container]! + image.size.height
        } else {
            generator.heights.content += image.size.height
        }
    }
}
