//
//  PDFGenerator+Image.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
//    func drawImage(_ container: PDFContainer, image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit, calculatingMetrics: Bool) throws {
//        var (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
//        
//        let y: CGFloat = try {
//            switch container.normalize {
//            case .headerLeft:
//                return headerHeight[container]!
//            case .contentLeft:
//                if (contentHeight + imageSize.height + captionSize.height > contentSize.height || (sizeFit == .height && imageSize.height < size.height)) {
//                    try generateNewPage(calculatingMetrics: calculatingMetrics)
//                    
//                    (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
//                    
//                    return contentHeight + maxHeaderHeight() + layout.space.header
//                }
//                return contentHeight + maxHeaderHeight() + layout.space.header
//            case .footerLeft:
//                return contentSize.height + maxHeaderHeight() + footerHeight[container]!
//            default:
//                return 0
//            }
//        }()
//        
//        let x: CGFloat = {
//            switch container {
//            case .headerLeft, .contentLeft, .footerLeft:
//                return layout.margin.side + indentation[container.normalize]!
//            case .headerCenter, .contentCenter, .footerCenter:
//                return layout.pageBounds.midX - imageSize.width / 2
//            case .headerRight, .contentRight, .footerRight:
//                return layout.pageBounds.width - layout.margin.side - imageSize.width
//            default:
//                return 0
//            }
//        }()
//        
//        let frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
//        try drawImage(container, image: image, frame: frame, caption: caption, calculatingMetrics: calculatingMetrics)
//    }
//    
//    func drawImagesInRow(_ container: PDFContainer, images: [UIImage], captions: [NSAttributedString], spacing: CGFloat, calculatingMetrics: Bool) throws {
//        assert(images.count > 0, "You need to provide at least one image!")
//        
//        let totalImagesWidth = contentSize.width - indentation[container.normalize]! - (CGFloat(images.count) - 1) * spacing
//        let imageWidth = totalImagesWidth / CGFloat(images.count)
//        
//        let calculateImageCaptionSizes: ([UIImage], [NSAttributedString]) -> ([CGSize], CGFloat) = {
//            images, captions in
//            
//            var (imageSizes, maxHeight): ([CGSize], CGFloat) = ([], 0)
//            for (index, image) in images.enumerated() {
//                let caption = (captions.count > index) ? captions[index] : NSAttributedString()
//                let (imageSize, captionSize) = self.calculateImageCaptionSize(container, image: image, size: CGSize(width: imageWidth, height: image.size.height), caption: caption, sizeFit: .width)
//                imageSizes.append(imageSize)
//                
//                if maxHeight < imageSize.height + captionSize.height {
//                    maxHeight = imageSize.height + captionSize.height
//                }
//            }
//            
//            return (imageSizes, maxHeight)
//        }
//        
//        var (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)
//        
//        var y = contentHeight + maxHeaderHeight() + layout.space.header
//        if (contentHeight + maxHeight > contentSize.height) {
//            try generateNewPage(calculatingMetrics: calculatingMetrics)
//            
//            y = contentHeight + maxHeaderHeight() + layout.space.header
//            (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)
//        }
//        
//        var x: CGFloat = layout.margin.side + indentation[container.normalize]!
//        
//        let (nowContentHeight, nowIndentation) = (contentHeight, indentation[container.normalize]!)
//        for (index, image) in images.enumerated() {
//            let imageSize = imageSizes[index]
//            let caption = (captions.count > index) ? captions[index] : NSAttributedString()
//            try drawImage(container, image: image, frame: CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height), caption: caption, calculatingMetrics: calculatingMetrics)
//            
//            x += imageSize.width + spacing
//            indentation[container.normalize] = indentation[container.normalize]! + imageSize.width + spacing
//            contentHeight = nowContentHeight
//        }
//        
//        indentation[container.normalize] = nowIndentation
//        contentHeight += maxHeight
//    }
//    
//    func drawImage(_ container: PDFContainer, image: UIImage, frame: CGRect, caption: NSAttributedString, calculatingMetrics: Bool) throws {
//        let compressedImage = resizeAndCompressImage(image: image, frame: frame)
//        
//        // Don't render when calculating metrics
//        if !calculatingMetrics {
//            if let resultImage = compressedImage {
//                resultImage.draw(in: frame)
//            } else {
//                image.draw(in: frame)
//            }
//        }
//        
//        if container.isHeader {
//            headerHeight[container] = headerHeight[container]! + frame.height
//        } else if container.isFooter {
//            footerHeight[container] = footerHeight[container]! + frame.height
//        } else {
//            contentHeight += frame.height
//        }
//        
//        if caption.length > 0 {
//            try drawAttributedText(container, text: caption, textMaxWidth: frame.size.width, calculatingMetrics: calculatingMetrics)
//        }
//    }
//
}
