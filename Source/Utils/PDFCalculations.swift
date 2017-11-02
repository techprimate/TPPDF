//
//  PDFCalculations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24/08/2017.
//

class PDFCalculations {

    // MARK: - INTERNAL STATIC FUNCS

    internal static func calculateText(generator: PDFGenerator,
                                       container: PDFContainer,
                                       text: NSAttributedString) -> (frame: CGRect, renderString: NSAttributedString, remainder: NSAttributedString?) {
        let availableSize = calculateAvailableFrame(for: generator, in: container)
        let (fittingText, textSize, remainder) = calculateTextFrameAndRemainder(of: text, in: availableSize)
        let origin = calculatePositionOfText(for: generator, in: container, with: textSize)
        
        return (
            CGRect(origin: origin, size: textSize),
            fittingText,
            remainder
        )
    }

    internal static func calculateTextFrameAndRemainder(of text: NSAttributedString,
                                                        in bounds: CGSize) -> (text: NSAttributedString, size: CGSize, remainder: NSAttributedString?) {
        let framesetter = CTFramesetterCreateWithAttributedString(text)
        let framePath = UIBezierPath(rect: CGRect(origin: .zero, size: bounds)).cgPath

        let textRange = CFRange(location: 0, length: text.length)

        // Get the frame that will do the rendering
        let frameRef = CTFramesetterCreateFrame(framesetter, textRange, framePath, nil)

        // Calculate the range of the string which actually fits in the frame
        let visibleRange = CTFrameGetVisibleStringRange(frameRef)

        // Calculate the actual size the string needs
        let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, bounds, nil)

        let castedRange = NSRange(location: 0, length: visibleRange.length)
        let result = text.attributedSubstring(from: castedRange)
        var remainder: NSAttributedString?

        if visibleRange.length != textRange.length {
            let remainderRange = NSRange(location: visibleRange.length, length: textRange.length - visibleRange.length)
            remainder = text.attributedSubstring(from: remainderRange)
        }

        return (result, drawnSize, remainder)
    }

    // MARK: - PRIVATE STATIC FUNCS
    
    private static func calculateAvailableFrame(for generator: PDFGenerator, in container: PDFContainer) -> CGSize {
        return CGSize(
            width: calculateAvailableFrameWidth(for: generator, in: container),
            height: calculateAvailableFrameHeight(for: generator, in: container)
        )
    }
    
    private static func calculateAvailableFrameWidth(for generator: PDFGenerator, in container: PDFContainer) -> CGFloat {
        let pageLayout = generator.document.layout
        
        return pageLayout.contentSize.width
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container)
    }
    
    private static func calculateAvailableFrameHeight(for generator: PDFGenerator, in container: PDFContainer) -> CGFloat {
        let layout = generator.layout
        let pageLayout = generator.document.layout
        
        if container.isHeader || container.isFooter {
            return pageLayout.height
        } else {
            return pageLayout.contentSize.height
                - layout.heights.maxHeaderHeight()
                - pageLayout.space.header
                - layout.heights.content
                - pageLayout.space.footer
                - layout.heights.maxFooterHeight()
        }
    }
    
    private static func calculatePositionOfText(for generator: PDFGenerator, in container: PDFContainer, with size: CGSize) -> CGPoint {
        return CGPoint(
            x: calculatePositionX(for: generator, in: container, with: size),
            y: calculatePositionY(for: generator, in: container, with: size)
        )
    }
    
    private static func calculatePositionX(for generator: PDFGenerator, in container: PDFContainer, with size: CGSize) -> CGFloat {
        let layout = generator.layout
        let pageLayout = generator.document.layout
        
        if container.isLeft {
            return pageLayout.margin.left
                + layout.indentation.leftIn(container: container)
        } else if container.isRight {
            return pageLayout.width
                - pageLayout.margin.right
                - layout.indentation.rightIn(container: container)
                - size.width
        } else {
            return pageLayout.margin.left
                + layout.indentation.leftIn(container: container)
                + (pageLayout.contentSize.width
                    - layout.indentation.leftIn(container: container)
                    - layout.indentation.rightIn(container: container)
                    - size.width
                ) / 2
        }
    }
    
    private static func calculatePositionY(for generator: PDFGenerator, in container: PDFContainer, with size: CGSize) -> CGFloat {
        let layout = generator.layout
        let pageLayout = generator.document.layout
        
        if container.isHeader {
            return pageLayout.margin.top
                + pageLayout.space.header
                + layout.heights.maxHeaderHeight()
        } else if container.isFooter {
            return pageLayout.height
                - pageLayout.margin.bottom
                - pageLayout.space.footer
                - layout.heights.maxFooterHeight()
        } else {
            return pageLayout.margin.top
                + layout.heights.maxHeaderHeight()
                + pageLayout.space.header
                + layout.heights.content
        }
    }
    
    // MARK: - LEGACY
    
    static func calculateCellFrame(generator: PDFGenerator,
                                   origin: CGPoint,
                                   width: CGFloat,
                                   text: NSAttributedString,
                                   alignment: PDFTableCellAlignment) -> CGRect {
        let layout = generator.document.layout
        
        let textMaxHeight = layout.height
            - generator.layout.heights.maxHeaderHeight()
            - layout.space.header
            - generator.layout.heights.maxFooterHeight()
            - layout.space.footer
            - generator.layout.heights.content
        
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
            - generator.layout.heights.maxHeaderHeight()
            - generator.document.layout.space.header
            - generator.layout.heights.maxFooterHeight()
            - generator.document.layout.space.footer
            - generator.layout.heights.content
        
        // The height is not enough
        if imageMaxHeight <= 0 {
            return CGRect.infinite
        }
        
        let imageSize = image.size
        let height = imageSize.height / imageSize.width * width
        
        return CGRect(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    static func calculateTextFrameAndDrawnSizeInOnePage(generator: PDFGenerator,
                                                        container: PDFContainer,
                                                        text: CFAttributedString,
                                                        currentRange: CFRange,
                                                        textMaxWidth: CGFloat) -> (CGRect, CTFrame, CGSize) {
        let textMaxWidth = (textMaxWidth > 0) ? textMaxWidth : (generator.document.layout.width
            - generator.document.layout.margin.left
            - generator.document.layout.margin.right
            - generator.layout.indentation.leftIn(container: container)
            - generator.layout.indentation.rightIn(container: container))
        
        let textMaxHeight: CGFloat = {
            if container.isHeader {
                return generator.document.layout.height
                    - generator.layout.heights.header[container]!
            } else if container.isFooter {
                return generator.document.layout.margin.bottom
            } else {
                return generator.document.layout.height
                    - generator.layout.heights.maxHeaderHeight()
                    - generator.document.layout.space.header
                    - generator.layout.heights.maxFooterHeight()
                    - generator.document.layout.space.footer
                    - generator.layout.heights.content
            }
        }()
        
        // Create a path object to enclose the text.
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return generator.document.layout.margin.left
                    + generator.layout.indentation.leftIn(container: container)
            case .headerCenter, .contentCenter, .footerCenter:
                return generator.document.layout.bounds.midX
                    - textMaxWidth / 2
            case .headerRight, .contentRight, .footerRight:
                return generator.document.layout.width
                    - generator.document.layout.margin.right
                    - textMaxWidth
            default:
                return 0
            }
        }()
        
        let frame: CGRect = {
            if container.isHeader {
                return CGRect(x: x,
                              y: 0,
                              width: textMaxWidth,
                              height: textMaxHeight)
            } else if container.isFooter {
                return CGRect(x: x,
                              y: generator.document.layout.height
                                - generator.layout.heights.footer[container]!,
                              width: textMaxWidth,
                              height: textMaxHeight)
            } else {
                return CGRect(x: x,
                              y: generator.layout.heights.content
                                + generator.layout.heights.maxHeaderHeight()
                                + generator.document.layout.space.header,
                              width: textMaxWidth,
                              height: textMaxHeight)
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
        let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, frame.size, nil)
        
        return (frame, frameRef, drawnSize)
    }
    
    static func calculateImageCaptionSize(generator: PDFGenerator,
                                          container: PDFContainer,
                                          image: PDFImage,
                                          size: CGSize,
                                          sizeFit: PDFImageSizeFit) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        let size = (size == CGSize.zero) ? image.size : size
        
        let maxWidth = min(size.width, generator.document.layout.contentSize.width - generator.layout.indentation.leftIn(container: container))
        let maxHeight = min(size.height, generator.document.layout.contentSize.height - generator.layout.heights.content)
        
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
        
        let (_, captionSize) = (NSAttributedString(), CGSize.zero)
        if let _ = image.caption {
//            if !caption.isEmpty {
//                let currentText = CFAttributedStringCreateCopy(nil, caption as CFAttributedString)
//                let currentRange = CFRange(location: 0, length: 0)
//                (_, _, captionSize) = calculateTextFrameAndDrawnSizeInOnePage(generator: generator,
//                                                                              container: container,
//                                                                              text: currentText!,
//                                                                              currentRange: currentRange,
//                                                                              textMaxWidth: imageSize.width)
//            }
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionSize.height))
    }
}
