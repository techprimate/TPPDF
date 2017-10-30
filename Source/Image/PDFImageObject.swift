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
    
    func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        var (imageSize, captionSize) = generator.calculateImageCaptionSize(container,
                                                                           image: image.image,
                                                                           size: image.size,
                                                                           caption: image.caption,
                                                                           sizeFit: image.sizeFit)
        
        let y: CGFloat = try {
            switch container.normalize {
            case .headerLeft:
                return generator.heights.header[container]!
            case .contentLeft:
                if generator.heights.content + imageSize.height + captionSize.height > generator.document.layout.contentSize.height ||
                    (image.sizeFit == .height && imageSize.height < image.size.height) {
//                    try generator.generateNewPage(calculatingMetrics: true)
                    
                    (imageSize, captionSize) = generator.calculateImageCaptionSize(container,
                                                                                   image: image.image,
                                                                                   size: image.size,
                                                                                   caption: image.caption,
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
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        let compressedImage = PDFGraphics.resizeAndCompressImage(image: image.image, frame: frame, quality: image.quality)
        compressedImage.draw(in: self.frame)
        
        if image.caption.length > 0 {
//            try generator.drawAttributedText(container, text: image.caption, textMaxWidth: frame.size.width, calculatingMetrics: false)
        }
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
