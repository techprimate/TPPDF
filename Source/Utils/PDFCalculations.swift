//
//  PDFCalculations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24/08/2017.
//
//

class PDFCalculations {
    
    static func calculateTextFrame(generator: PDFGenerator, container: PDFContainer, text: NSAttributedString) -> CGRect {
        return CGRect.zero
    }
    
    static func calculateCellFrame(generator: PDFGenerator, origin: CGPoint, width: CGFloat, text: NSAttributedString, alignment: PDFTableCellAlignment) -> CGRect {
        let layout = generator.document.layout
        
        let textMaxHeight = layout.height
            - generator.maxHeaderHeight()
            - layout.space.header
            - generator.maxFooterHeight()
            - layout.space.footer
            - generator.heights.content
        
        // The height is not enough
        if textMaxHeight <= 0 {
            return CGRect.infinite
        }
        let frame: CGRect = CGRect(x: origin.x, y: origin.y, width: width, height: textMaxHeight)
        
        let currentRange = CFRange(location: 0, length: 0)
        let (_, _, drawnSize) = calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
        let x: CGFloat = {
            switch alignment.normalizeHorizontal {
            case .center:
                return origin.x + width / 2 - drawnSize.width / 2
            case .right:
                return origin.x + width - drawnSize.width
            default:
                return origin.x
            }
        }()
        
        return CGRect(origin: CGPoint(x: x, y: origin.y), size: CGSize(width: drawnSize.width, height: drawnSize.height))
    }
    
    static func calculateCellFrame(generator: PDFGenerator, origin: CGPoint, width: CGFloat, image: UIImage) -> CGRect {
        let imageMaxHeight = generator.document.layout.height
            - generator.maxHeaderHeight()
            - generator.document.layout.space.header
            - generator.maxFooterHeight()
            - generator.document.layout.space.footer
            - generator.heights.content
        
        // The height is not enough
        if imageMaxHeight <= 0 {
            return CGRect.infinite
        }
        
        let imageSize = image.size
        let height = imageSize.height / imageSize.width * width
        
        return CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    static func calculateTextFrameAndDrawnSizeInOnePage(generator: PDFGenerator, container: PDFContainer,
                                                 text: CFAttributedString,
                                                 currentRange: CFRange,
                                                 textMaxWidth: CGFloat) -> (CGRect, CTFrame, CGSize) {
        let textMaxWidth = (textMaxWidth > 0) ? textMaxWidth : (generator.document.layout.width
            - generator.document.layout.margin.left
            - generator.document.layout.margin.right
            - generator.indentation.leftIn(container: container)
            - generator.indentation.rightIn(container: container))
        let textMaxHeight: CGFloat = {
            if container.isHeader {
                return generator.document.layout.height - generator.heights.header[container]!
            } else if container.isFooter {
                return generator.document.layout.margin.footer
            } else {
                return generator.document.layout.height
                    - generator.maxHeaderHeight()
                    - generator.document.layout.space.header
                    - generator.maxFooterHeight()
                    - generator.document.layout.space.footer
                    - generator.heights.content
            }
        }()
        
        // Create a path object to enclose the text.
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return generator.document.layout.margin.left + generator.indentation.leftIn(container: container)
            case .headerCenter, .contentCenter, .footerCenter:
                return generator.document.layout.bounds.midX - textMaxWidth / 2
            case .headerRight, .contentRight, .footerRight:
                return generator.document.layout.width - generator.document.layout.margin.right - textMaxWidth
            default:
                return 0
            }
        }()
        
        let frame: CGRect = {
            if container.isHeader {
                return CGRect(x: x, y: 0, width: textMaxWidth, height: textMaxHeight)
            } else if container.isFooter {
                return CGRect(x: x, y: generator.document.layout.height - generator.heights.footer[container]!, width: textMaxWidth, height: textMaxHeight)
            } else {
                return CGRect(x: x, y: generator.heights.content + generator.maxHeaderHeight() + generator.document.layout.space.header, width: textMaxWidth, height: textMaxHeight)
            }
        }()
        
        return calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
    }
    
    static func calculateTextFrameAndDrawnSizeInOnePage(frame: CGRect, text: CFAttributedString, currentRange: CFRange) -> (CGRect, CTFrame, CGSize) {
        let framesetter = CTFramesetterCreateWithAttributedString(text)
        let framePath = UIBezierPath(rect: frame).cgPath
        
        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        let frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
        
        // Update the current range based on what was drawn.
        let visibleRange = CTFrameGetVisibleStringRange(frameRef)
        
        // Update last drawn frame
        let constraintSize = frame.size
        let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, constraintSize, nil)
        
        return (frame, frameRef, drawnSize)
    }
    
    static func calculateImageCaptionSize(generator: PDFGenerator, container: PDFContainer, image: UIImage, caption: NSAttributedString,
                                   size: CGSize, sizeFit: ImageSizeFit) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        let size = (size == CGSize.zero) ? image.size : size
        
        let maxWidth = min(size.width, generator.document.layout.contentSize.width - generator.indentation.leftIn(container: container))
        let maxHeight = min(size.height, generator.document.layout.contentSize.height - generator.heights.content)
        
        let wFactor = image.size.width / maxWidth
        let hFactor = image.size.height / maxHeight
        let factor: CGFloat = {
            switch sizeFit {
            case .width:
                return wFactor
            case .height:
                return hFactor
            case .widthHeight:
                return max(wFactor, hFactor)
            }
        }()
        
        let imageSize = CGSize(width: image.size.width / factor, height: image.size.height / factor)
        
        var (_, captionSize) = (NSAttributedString(), CGSize.zero)
        if caption.length > 0 {
            let currentText = CFAttributedStringCreateCopy(nil, caption as CFAttributedString)
            let currentRange = CFRange(location: 0, length: 0)
            (_, _, captionSize) = calculateTextFrameAndDrawnSizeInOnePage(generator: generator,
                                                                          container: container,
                                                                          text: currentText!,
                                                                          currentRange: currentRange,
                                                                          textMaxWidth: imageSize.width)
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionSize.height))
    }
}
