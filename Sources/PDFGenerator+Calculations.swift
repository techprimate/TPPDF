//
//  PDFGenerator+Calculations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func resetHeaderFooterHeight() {
        headerHeight[.headerLeft] = layout.margin.header
        headerHeight[.headerCenter] = layout.margin.header
        headerHeight[.headerRight] = layout.margin.header
        
        footerHeight[.footerLeft] = layout.margin.footer
        footerHeight[.footerCenter] = layout.margin.footer
        footerHeight[.footerRight] = layout.margin.footer
    }
    
    func maxHeaderHeight() -> CGFloat {
        return max(layout.margin.side, max(headerHeight[.headerLeft]!, max(headerHeight[.headerCenter]!, headerHeight[.headerRight]!)))
    }
    
    func maxFooterHeight() -> CGFloat {
        return max(layout.margin.side, max(footerHeight[.footerLeft]!, max(footerHeight[.footerCenter]!, footerHeight[.footerRight]!)))
    }
    
    func calculateCellFrame(_ origin: CGPoint, width: CGFloat, text: NSAttributedString, alignment: PDFTableCellAlignment) -> CGRect {
        let textMaxHeight = layout.pageBounds.height - maxHeaderHeight() - layout.space.header - maxFooterHeight() - layout.space.footer - contentHeight
        // The height is not enough
        if (textMaxHeight <= 0) {
            return CGRect.infinite
        }
        let frame: CGRect = CGRect(x: origin.x, y: origin.y, width: width, height: textMaxHeight)
        
        let currentRange = CFRange(location: 0, length: 0)
        let (_, drawnSize) = calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
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
        let imageMaxHeight = layout.pageBounds.height - maxHeaderHeight() - layout.space.header - maxFooterHeight() - layout.space.footer - contentHeight
        // The height is not enough
        if (imageMaxHeight <= 0) {
            return CGRect.infinite
        }
        
        let imageSize = image.size
        let height = imageSize.height / imageSize.width * width
        
        let frame: CGRect = CGRect(x: origin.x, y: origin.y, width: width, height: height)
        return frame
    }
    
    func calculateTextFrameAndDrawnSizeInOnePage(frame: CGRect, text: CFAttributedString, currentRange: CFRange) -> (CTFrame, CGSize) {
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
        
        return (frameRef, drawnSize)
    }
    
    func calculateTextFrameAndDrawnSizeInOnePage(_ container: PDFContainer, text: CFAttributedString, currentRange: CFRange, textMaxWidth: CGFloat) -> (CTFrame, CGSize) {
        let textMaxWidth = (textMaxWidth > 0) ? textMaxWidth : layout.pageBounds.width - 2 * layout.margin.side - indentation[container.normalize]!
        let textMaxHeight: CGFloat = {
            if container.isHeader {
                return layout.pageBounds.height - headerHeight[container]!
            } else if container.isFooter {
                return layout.margin.footer
            } else {
                return layout.pageBounds.height - maxHeaderHeight() - layout.space.header - maxFooterHeight() - layout.space.footer - contentHeight
            }
        }()
        
        // Create a path object to enclose the text.
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return layout.margin.side + indentation[container.normalize]!
            case .headerCenter, .contentCenter, .footerCenter:
                return layout.pageBounds.midX - textMaxWidth / 2
            case .headerRight, .contentRight, .footerRight:
                return layout.pageBounds.width - layout.margin.side - textMaxWidth
            default:
                return 0
            }
        }()
        
        let frame: CGRect = {
            if container.isHeader {
                return CGRect(x: x, y: 0, width: textMaxWidth, height: textMaxHeight)
            } else if container.isFooter {
                return CGRect(x: x, y: footerHeight[container]!, width: textMaxWidth, height: textMaxHeight)
            } else {
                return CGRect(x: x, y: maxFooterHeight() + layout.space.footer, width: textMaxWidth, height: textMaxHeight)
            }
        }()
        
        return calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
    }
    
    func calculateImageCaptionSize(_ container: PDFContainer, image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        let size = (size == CGSize.zero) ? image.size : size
        
        let maxWidth = min(size.width, contentSize.width - indentation[container.normalize]!)
        let maxHeight = min(size.height, contentSize.height - contentHeight)
        
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
            (_, captionSize) = calculateTextFrameAndDrawnSizeInOnePage(container, text: currentText!, currentRange: currentRange, textMaxWidth: imageSize.width)
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionSize.height))
    }
}
