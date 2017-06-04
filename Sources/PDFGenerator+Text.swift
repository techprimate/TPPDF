//
//  PDFGenerator+Text.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func drawText(_ container: Container, text: String, spacing: CGFloat, textMaxWidth: CGFloat = 0) {
        let attributes = generateDefaultTextAttributes(container, spacing: spacing)
        
        drawAttributedText(container, text: NSAttributedString(string: text, attributes: attributes), textMaxWidth: textMaxWidth)
    }
    
    func drawAttributedText(_ container: Container, text: NSAttributedString, textMaxWidth: CGFloat = 0) {
        let currentText = CFAttributedStringCreateCopy(nil, text as CFAttributedString)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        
        repeat {
            let (frameRef, drawnSize) = calculateTextFrameAndDrawnSizeInOnePage(container, text: currentText!, currentRange: currentRange, textMaxWidth: textMaxWidth)
            // Get the graphics context.
            let currentContext = UIGraphicsGetCurrentContext()!
            
            // Push state
            currentContext.saveGState()
            
            // Put the text matrix into a known state. This ensures
            // that no old scaling factors are left in place.
            currentContext.textMatrix = CGAffineTransform.identity
            
            // Core Text draws from the bottom-left corner up, so flip
            // the current transform prior to drawing.
            currentContext.translateBy(x: 0, y: pageBounds.height)
            currentContext.scaleBy(x: 1.0, y: -1.0)
            
            // Draw the frame.
            CTFrameDraw(frameRef, currentContext)
            
            // Pop state
            currentContext.restoreGState()
            
            // Update the current range based on what was drawn.
            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
            currentRange = CFRange(location: visibleRange.location + visibleRange.length , length: 0)
            
            if container.isHeader {
                headerHeight[container] = headerHeight[container]! + drawnSize.height
            } else if container.isFooter {
                footerHeight[container] = footerHeight[container]! + drawnSize.height
            } else {
                contentHeight += drawnSize.height
            }
            if currentRange.location == CFAttributedStringGetLength(currentText) {
                done = true
            } else {
                generateNewPage()
            }
        } while(!done)
    }
    
    func generateDefaultTextAttributes(_ container: Container, spacing: CGFloat) -> [String: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        switch container {
        case .headerLeft, .contentLeft, .footerLeft:
            paragraphStyle.alignment = .left
        case .headerCenter, .contentCenter, .footerCenter:
            paragraphStyle.alignment = .center
        case .headerRight, .contentRight, .footerRight:
            paragraphStyle.alignment = .right
        default:
            paragraphStyle.alignment = .left
        }
        
        paragraphStyle.lineSpacing = spacing
        
        return [
            NSFontAttributeName: fonts[container]!,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
    }
}
