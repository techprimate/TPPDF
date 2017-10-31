//
//  PDFAttributedTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFAttributedTextObject : PDFObject {
    
    var attributedText: PDFAttributedText?
    var simpleText: PDFSimpleText?
    
    var attributedString: NSAttributedString!
    
    convenience init(text: PDFText) {
        if let attributedText = text as? PDFAttributedText {
            self.init(attributedText: attributedText)
        } else if let simpleText = text as? PDFSimpleText {
            self.init(simpleText: simpleText)
        } else {
            fatalError()
        }
    }
    
    init(attributedText: PDFAttributedText) {
        self.attributedText = attributedText
    }
    
    init(simpleText: PDFSimpleText) {
        self.simpleText = simpleText
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []
        
        attributedString = try generateAttributedText(generator: generator, container: container)
        
        result.append((container, self))
//
//        let currentText = CFAttributedStringCreateCopy(nil, attributedText as CFAttributedString)
//        var currentRange = CFRange(location: 0, length: 0)
//        var done = false
//
//        let textMaxWidth = generator.document.layout.contentSize.width
//            - generator.indentation.leftIn(container: container)
//            - generator.indentation.rightIn(container: container)
//
//        repeat {
//            let (calcFrame, frameRef, drawnSize) = PDFCalculations.calculateTextFrameAndDrawnSizeInOnePage(generator: generator,
//                                                                                                           container: container,
//                                                                                                           text: currentText!,
//                                                                                                           currentRange: currentRange,
//                                                                                                           textMaxWidth: textMaxWidth)
//
//            // Get the graphics context.
//            let currentContext = UIGraphicsGetCurrentContext()!
//
//            // Push state
//            currentContext.saveGState()
//
//            // Put the text matrix into a known state. This ensures
//            // that no old scaling factors are left in place.
//            currentContext.textMatrix = CGAffineTransform.identity
//
//            // Core Text draws from the bottom-left corner up, so flip
//            // the current transform prior to drawing.
//            currentContext.translateBy(x: 0, y: generator.document.layout.height)
//            currentContext.scaleBy(x: 1.0, y: -1.0)
//
//            // Pop state
//            currentContext.restoreGState()
//
//            // Update the current range based on what was drawn.
//            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
//            currentRange = CFRange(location: visibleRange.location + visibleRange.length, length: 0)
//
//            let substring = (currentText as! NSAttributedString).attributedSubstring(
//                from: NSRange(location: visibleRange.location, length: visibleRange.length))
//            let subObject = SubTextObject(text: substring, frame: calcFrame) // TODO: Insert correct attributed substring
//            subTextObjects.append(subObject)
//            self.frame = calcFrame
//
//            if container.isHeader {
//                generator.heights.header[container] = generator.heights.header[container]! + drawnSize.height
//            } else if container.isFooter {
//                generator.heights.footer[container] = generator.heights.footer[container]! + drawnSize.height
//            } else {
//                generator.heights.content += drawnSize.height
//            }
//            if currentRange.location == CFAttributedStringGetLength(currentText) {
//                done = true
//            } else {
////                try generator.generateNewPage(calculatingMetrics: true)
//            }
//        } while !done
        
        return result
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        attributedString.draw(in: self.frame)
        if PDFGenerator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .full, color: .red, width: 1.0), fill: .green)
        }
    }
    
    func generateAttributedText(generator: PDFGenerator, container: PDFContainer) throws -> NSAttributedString {
        if let simple = self.simpleText {
            let attributes = PDFAttributedTextObject.generateDefaultTextAttributes(
                container: container,
                fonts: &generator.fonts,
                textColor: generator.textColor,
                spacing: simple.spacing)
            
            return NSAttributedString(string: simple.text, attributes: attributes)
        } else if let attributedText = self.attributedText {
            return attributedText.text
        } else {
            throw PDFError.textObjectIsNil
        }
    }
    
    static func generateDefaultTextAttributes(container: PDFContainer,
                                              fonts: inout [PDFContainer: UIFont],
                                              textColor: UIColor,
                                              spacing: CGFloat) -> [NSAttributedStringKey: NSObject] {
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
            NSAttributedStringKey.font: fonts[container]!,
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: textColor
        ]
    }
}
