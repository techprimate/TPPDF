//
//  PDFAttributedTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
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
        
        let (frame, renderString, leftOverString) = PDFCalculations.calculateText(generator: generator,
                                                                                  container: container,
                                                                                  text: attributedString)
        
        attributedString = renderString
        self.frame = frame
        
        result.append((container, self))
        
        if container.isHeader {
            generator.layout.heights.header[container] = generator.layout.heights.header[container]! + frame.height
        } else if container.isFooter {
            generator.layout.heights.footer[container] = generator.layout.heights.footer[container]! + frame.height
        } else {
            generator.layout.heights.content += frame.height
        }
        
        if let left = leftOverString {
            result += [(container, PDFPageBreakObject())]
            generator.layout.reset()
            
            let subText = PDFAttributedText(text: left)
            let textObject = PDFAttributedTextObject(attributedText: subText)
            result += try textObject.calculate(generator: generator, container: container)
        }
        
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
