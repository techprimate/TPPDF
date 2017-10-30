//
//  PDFImageRowObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFImageRowObject: PDFObject {
    
    var images: [PDFImage]
    var spacing: CGFloat
    
    init(images: [PDFImage], spacing: CGFloat = 1.0) {
        self.images = images
        self.spacing = spacing
    }
    
    
    
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
}
