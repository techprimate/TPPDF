//
//  PDFGenerator+Calculations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func resetHeaderFooterHeight() {
        let margin = document.layout.margin
        
        heights.header[.headerLeft] = margin.header
        heights.header[.headerCenter] = margin.header
        heights.header[.headerRight] = margin.header
        
        heights.footer[.footerLeft] = margin.footer
        heights.footer[.footerCenter] = margin.footer
        heights.footer[.footerRight] = margin.footer
    }
    
    func maxHeaderHeight() -> CGFloat {
        return heights.header.values.max() ?? 0
    }
    
    func maxFooterHeight() -> CGFloat {
        return heights.footer.values.max() ?? 0
    }
    
    func calculateCellFrame(_ origin: CGPoint, width: CGFloat, text: NSAttributedString, alignment: PDFTableCellAlignment) -> CGRect {
        let layout = document.layout
        
        let textMaxHeight = layout.height
            - maxHeaderHeight()
            - layout.space.header
            - maxFooterHeight()
            - layout.space.footer
            - heights.content
        
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
    
    func calculateCellFrame(_ origin: CGPoint, width: CGFloat, image: UIImage) -> CGRect {
        let imageMaxHeight = document.layout.height
            - maxHeaderHeight()
            - document.layout.space.header
            - maxFooterHeight()
            - document.layout.space.footer
            - heights.content
        
        // The height is not enough
        if imageMaxHeight <= 0 {
            return CGRect.infinite
        }
        
        let imageSize = image.size
        let height = imageSize.height / imageSize.width * width
        
        return CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    func calculateTextFrameAndDrawnSizeInOnePage(_ container: PDFContainer,
                                                 text: CFAttributedString,
                                                 currentRange: CFRange,
                                                 textMaxWidth: CGFloat) -> (CGRect, CTFrame, CGSize) {
        let textMaxWidth = (textMaxWidth > 0) ? textMaxWidth : (document.layout.width
            - document.layout.margin.left
            - document.layout.margin.right
            - indentation.leftIn(container: container)
            - indentation.rightIn(container: container))
        let textMaxHeight: CGFloat = {
            if container.isHeader {
                return document.layout.height - heights.header[container]!
            } else if container.isFooter {
                return document.layout.margin.footer
            } else {
                return document.layout.height
                    - maxHeaderHeight()
                    - document.layout.space.header
                    - maxFooterHeight()
                    - document.layout.space.footer
                    - heights.content
            }
        }()
        
        // Create a path object to enclose the text.
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return document.layout.margin.left + indentation.leftIn(container: container)
            case .headerCenter, .contentCenter, .footerCenter:
                return document.layout.bounds.midX - textMaxWidth / 2
            case .headerRight, .contentRight, .footerRight:
                return document.layout.width - document.layout.margin.right - textMaxWidth
            default:
                return 0
            }
        }()
        
        let frame: CGRect = {
            if container.isHeader {
                return CGRect(x: x, y: 0, width: textMaxWidth, height: textMaxHeight)
            } else if container.isFooter {
                return CGRect(x: x, y: document.layout.height - heights.footer[container]!, width: textMaxWidth, height: textMaxHeight)
            } else {
                return CGRect(x: x, y: heights.content + maxHeaderHeight() + document.layout.space.header, width: textMaxWidth, height: textMaxHeight)
            }
        }()
        
        return calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
    }
    
    func calculateTextFrameAndDrawnSizeInOnePage(frame: CGRect, text: CFAttributedString, currentRange: CFRange) -> (CGRect, CTFrame, CGSize) {
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
    
    func calculateImageCaptionSize(_ container: PDFContainer,
                                   image: UIImage,
                                   size: CGSize,
                                   caption: NSAttributedString,
                                   sizeFit: ImageSizeFit) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        let size = (size == CGSize.zero) ? image.size : size
        
        let maxWidth = min(size.width, document.layout.contentSize.width - indentation.leftIn(container: container))
        let maxHeight = min(size.height, document.layout.contentSize.height - heights.content)
        
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
            (_, _, captionSize) = calculateTextFrameAndDrawnSizeInOnePage(container,
                                                                          text: currentText!,
                                                                          currentRange: currentRange,
                                                                          textMaxWidth: imageSize.width)
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionSize.height))
    }
}
