//
//  PDFGenerator+Image.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func drawImage(_ container: Container, image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit) {
        var (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
        
        let y: CGFloat = {
            switch container.normalize {
            case .headerLeft:
                return headerHeight[container]!
            case .contentLeft:
                if (contentHeight + imageSize.height + captionSize.height > contentSize.height || (sizeFit == .height && imageSize.height < size.height)) {
                    generateNewPage()
                    
                    (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
                    
                    return contentHeight + maxHeaderHeight() + headerSpace
                }
                return contentHeight + maxHeaderHeight() + headerSpace
            case .footerLeft:
                return contentSize.height + maxHeaderHeight() + footerHeight[container]!
            default:
                return 0
            }
        }()
        
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return pageMargin + indentation[container.normalize]!
            case .headerCenter, .contentCenter, .footerCenter:
                return pageBounds.midX - imageSize.width / 2
            case .headerRight, .contentRight, .footerRight:
                return pageBounds.width - pageMargin - imageSize.width
            default:
                return 0
            }
        }()
        
        let frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
        drawImage(container, image: image, frame: frame, caption: caption)
    }
    
    func drawImagesInRow(_ container: Container, images: [UIImage], captions: [NSAttributedString], spacing: CGFloat) {
        assert(images.count > 0, "You need to provide at least one image!")
        
        let totalImagesWidth = contentSize.width - indentation[container.normalize]! - (CGFloat(images.count) - 1) * spacing
        let imageWidth = totalImagesWidth / CGFloat(images.count)
        
        let calculateImageCaptionSizes: ([UIImage], [NSAttributedString]) -> ([CGSize], CGFloat) = {
            images, captions in
            
            var (imageSizes, maxHeight): ([CGSize], CGFloat) = ([], 0)
            for (index, image) in images.enumerated() {
                let caption = (captions.count > index) ? captions[index] : NSAttributedString()
                let (imageSize, captionSize) = self.calculateImageCaptionSize(container, image: image, size: CGSize(width: imageWidth, height: image.size.height), caption: caption, sizeFit: .width)
                imageSizes.append(imageSize)
                
                if maxHeight < imageSize.height + captionSize.height {
                    maxHeight = imageSize.height + captionSize.height
                }
            }
            
            return (imageSizes, maxHeight)
        }
        
        var (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)
        
        var y = contentHeight + maxHeaderHeight() + headerSpace
        if (contentHeight + maxHeight > contentSize.height) {
            generateNewPage()
            
            y = contentHeight + maxHeaderHeight() + headerSpace
            (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)
        }
        
        var x: CGFloat = pageMargin + indentation[container.normalize]!
        
        let (nowContentHeight, nowIndentation) = (contentHeight, indentation[container.normalize]!)
        for (index, image) in images.enumerated() {
            let imageSize = imageSizes[index]
            let caption = (captions.count > index) ? captions[index] : NSAttributedString()
            drawImage(container, image: image, frame: CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height), caption: caption)
            
            x += imageSize.width + spacing
            indentation[container.normalize] = indentation[container.normalize]! + imageSize.width + spacing
            contentHeight = nowContentHeight
        }
        
        indentation[container.normalize] = nowIndentation
        contentHeight += maxHeight
    }
    
    func drawImage(_ container: Container, image: UIImage, frame: CGRect, caption: NSAttributedString) {
        // resize
        let resizeFactor = (3 * imageQuality > 1) ? 3 * imageQuality : 1
        let resizeImageSize = CGSize(width: frame.size.width * resizeFactor, height: frame.size.height * resizeFactor)
        
        UIGraphicsBeginImageContext(resizeImageSize)
        image.draw(in: CGRect(x:0, y:0, width: resizeImageSize.width, height: resizeImageSize.height))
        var compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // compression
        if let image = compressedImage, let jpegData = UIImageJPEGRepresentation(image, imageQuality) {
            compressedImage = UIImage(data: jpegData)
        }
        
        if let resultImage = compressedImage {
            resultImage.draw(in: frame)
        } else {
            image.draw(in: frame)
        }
        
        if container.isHeader {
            headerHeight[container] = headerHeight[container]! + frame.height
        } else if container.isFooter {
            footerHeight[container] = footerHeight[container]! + frame.height
        } else {
            contentHeight += frame.height
        }
        
        if caption.length > 0 {
            drawAttributedText(container, text: caption, textMaxWidth: frame.size.width)
        }
    }
}
