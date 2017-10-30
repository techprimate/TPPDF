//
//  PDFAttributedTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFAttributedTextObject : PDFObject {
    
    var simple: (text: String, spacing: CGFloat)? {
        didSet {
            subTextObjects = []
        }
    }
    
    var attributedText: NSAttributedString? {
        didSet {
            subTextObjects = []
        }
    }
    
    struct SubTextObject {
        var text: NSAttributedString
        var frame: CGRect
    }
    
    private var subTextObjects: [SubTextObject] = []
    
    init(attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }
    
    init(text: String, spacing: CGFloat = 1.0) {
        self.simple = (text: text, spacing: spacing)
    }
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        let attributedText = try generateAttributedText(generator: generator, container: container)
        
        let currentText = CFAttributedStringCreateCopy(nil, attributedText as CFAttributedString)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        
        let textMaxWidth = generator.contentSize.width - generator.indentation[container.normalize]!
        
        repeat {
            let (calcFrame, frameRef, drawnSize) = generator.calculateTextFrameAndDrawnSizeInOnePage(container,
                                                                                                     text: currentText!,
                                                                                                     currentRange: currentRange,
                                                                                                     textMaxWidth: textMaxWidth)
            
            // Get the graphics context.
            let currentContext = UIGraphicsGetCurrentContext()!
            
            // Push state
            currentContext.saveGState()
            
            // Put the text matrix into a known state. This ensures
            // that no old scaling factors are left in place.
            currentContext.textMatrix = CGAffineTransform.identity
            
            // Core Text draws from the bottom-left corner up, so flip
            // the current transform prior to drawing.
            currentContext.translateBy(x: 0, y: generator.document.layout.pageBounds.height)
            currentContext.scaleBy(x: 1.0, y: -1.0)
            
            // Pop state
            currentContext.restoreGState()
            
            // Update the current range based on what was drawn.
            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
            currentRange = CFRange(location: visibleRange.location + visibleRange.length, length: 0)
            
            let substring = (currentText as! NSAttributedString).attributedSubstring(
                from: NSRange(location: visibleRange.location, length: visibleRange.length))
            let subObject = SubTextObject(text: substring, frame: calcFrame) // TODO: Insert correct attributed substring
            subTextObjects.append(subObject)
            self.frame = calcFrame
            
            if container.isHeader {
                generator.heights.header[container] = generator.heights.header[container]! + drawnSize.height
            } else if container.isFooter {
                generator.heights.footer[container] = generator.heights.footer[container]! + drawnSize.height
            } else {
                generator.heights.content += drawnSize.height
            }
            if currentRange.location == CFAttributedStringGetLength(currentText) {
                done = true
            } else {
                try generator.generateNewPage(calculatingMetrics: true)
            }
        } while !done
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        for object in subTextObjects {
            object.text.draw(in: object.frame)
        }
    }
    
    func generateAttributedText(generator: PDFGenerator, container: PDFContainer, attributedText: NSAttributedString? = nil) throws -> NSAttributedString {
        var attributedText: NSAttributedString! = attributedText ?? self.attributedText
        
        if let simple = self.simple {
            let attributes = PDFAttributedTextObject.generateDefaultTextAttributes(container: container, fonts: &generator.fonts, textColor: generator.textColor, spacing: simple.spacing)
            attributedText = NSAttributedString(string: simple.text, attributes: attributes)
        }
        
        if attributedText == nil {
            throw PDFError.textObjectIsNil
        }
        return attributedText
    }
    
    static func generateDefaultTextAttributes(container: PDFContainer, fonts: inout [PDFContainer: UIFont], textColor: UIColor, spacing: CGFloat) -> [String: NSObject] {
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
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: textColor
        ]
    }
}
