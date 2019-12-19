//
//  PDFAttributedTextObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 Calculates and draws a text
 */
internal class PDFAttributedTextObject: PDFRenderObject {

    /**
     Instance of attributed text object, holds instance of `NSAttributedString`
     */
    internal var attributedText: PDFAttributedText?

    /**
     Instance of simple text object, will be converted into a attributed string
     */
    internal var simpleText: PDFSimpleText?

    /**
     Attributed string which will be drawn
     */
    internal var attributedString: NSAttributedString!

    /**

     If the given parameter `text` is neither a
     instance of `PDFAttributedText` nor a `PDFSimpleText` a `fatalError()` will be thrown,
     as there are no more subclasses of `PDFText` in the TPPDF framework.

     - parameter text: Subclass of `PDFText`
     */
    internal convenience init<T: PDFText>(text: T) {
        if let attributedText = text as? PDFAttributedText {
            self.init(attributedText: attributedText)
        } else if let simpleText = text as? PDFSimpleText {
            self.init(simpleText: simpleText)
        } else {
            fatalError()
        }
    }

    /**
     Initialize with attributed text.

     - parameter attributedText: Object holding instance of `NSAttributedString`
     */
    internal init(attributedText: PDFAttributedText) {
        self.attributedText = attributedText
    }

    /**
     Initalize with simple text object.
     Will be converted into a attributed string using the default values from the generator.

     - parameter simpleText: Simple text object
     */
    internal init(simpleText: PDFSimpleText) {
        self.simpleText = simpleText
    }

    /**
     Calculates the frame and the text which will be drawn.
     Also returns one or multiple page breaks and text objects, if text does not fit on one page.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFRenderObject)] {
        var result: [(PDFContainer, PDFRenderObject)] = []

        // Generate attributed string if simple text, otherwise uses given attributedText
        attributedString = try generateAttributedText(generator: generator, container: container)

        // Calculate the text frame and the text which is on this page
        // If it is not possible to draw the whole text on this page, a remainder text is returned
        let (frame, renderString, remainder) = PDFCalculations.calculateText(generator: generator,
                                                                             container: container,
                                                                             text: attributedString)

        // Set data to self, and add it to results
        attributedString = renderString
        self.frame = frame

        if attributedString.length > 0 {
            result.append((container, self))
        }

        // Update generator content height
        generator.layout.heights.add(frame.height, to: container)

        // If text is remainding, create a pagebreak and recursively add remainder text
        if let left = remainder {
            result += try PDFPageBreakObject().calculate(generator: generator, container: container)

            let subText = PDFAttributedText(text: left)
            let textObject = PDFAttributedTextObject(attributedText: subText)
            result += try textObject.calculate(generator: generator, container: container)
        }

        return result
    }

    /**
     Draws the text in the calculated frame using the Core Text framework.

     - parameter generator: Unused
     - parameter container: Unused

     - throws: None
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer) throws {
        if attributedString == nil {
            throw PDFError.textObjectNotCalculated
        }

        // Get current graphics context
        let currentContext = UIGraphicsGetCurrentContext()!

        // Create a core text frame setter
        let framesetter = CTFramesetterCreateWithAttributedString(attributedString)

        // Save context pre manipulation
        currentContext.saveGState()

        // Reset text matrix, so no text scaling is affected
        currentContext.textMatrix = CGAffineTransform.identity

        // Create the frame and a rectangular path of the text frame
        let frameRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let framePath = UIBezierPath(rect: frameRect).cgPath

        // Create core text frame for the given attributed string
        // The whole text should fit the frame, as calculations were already done
        let frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributedString.length), framePath, nil)

        // Translate by 100% graphics height up and reverse scale, as core text does draw from bottom up and not from top down
        currentContext.translateBy(x: 0, y: UIGraphicsGetPDFContextBounds().height)
        currentContext.scaleBy(x: 1.0, y: -1.0)

        // Translate context to actual position of text
        currentContext.translateBy(x: frame.minX, y: UIGraphicsGetPDFContextBounds().height - frame.maxY)

        // Draw text into context
        CTFrameDraw(frameRef, currentContext)

        // Restore context to pre manipulation
        currentContext.restoreGState()

        // If debugging is enabled, draw a outline around the text
        if generator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .dashed, color: .red, width: 1.0), fill: .clear)
        }

        let allRange = NSRange(location: 0, length: attributedString.length)
        var links: [(String, NSRange)] = []
        attributedString.enumerateAttribute(.link, in: allRange) { (obj, range, _) in
            if let url = obj as? String {
                links.append((url, range))
            }
        }

        calculateLinkAttributes(with: links, in: frameRef, in: allRange, context: currentContext, debug: generator.debug)
        applyAttributes()
    }

    private func calculateLinkAttributes(with links: [(url: String, range: NSRange)], in frameRef: CTFrame, in allRange: NSRange, context: CGContext, debug: Bool) {
        guard let lines = CTFrameGetLines(frameRef) as? [CTLine] else {
            return
        }
        var lineMetrics: [(line: CTLine, bounds: CGRect, range: CFRange)] = []
        for (i, line) in lines.enumerated() {
            var ascent: CGFloat = 0
            var descent: CGFloat = 0
            var leading: CGFloat = 0
            let typoBounds = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, &leading))

            var lineOrigin = CGPoint.zero
            CTFrameGetLineOrigins(frameRef, CFRange(location: lines.count - i - 1, length: 1), &lineOrigin)

            let lineBounds = CGRect(x: self.frame.origin.x,
                                    y: self.frame.origin.y + lineOrigin.y,
                                    width: typoBounds,
                                    height: ascent + descent + leading)
            lineMetrics.append((line: line, bounds: lineBounds, range: CTLineGetStringRange(line)))
        }
        for link in links {
            for metric in lineMetrics {
                if let intersection = NSRange(location: metric.range.location,
                                              length: metric.range.length).intersection(link.range) {
                    let startOffset = CTLineGetOffsetForStringIndex(metric.line, intersection.location, nil)
                    let endOffset = CTLineGetOffsetForStringIndex(metric.line, intersection.location + intersection.length, nil)

                    let linkFrame = CGRect(
                        x: self.frame.origin.x + startOffset,
                        y: metric.bounds.origin.y,
                        width: endOffset - startOffset,
                        height: metric.bounds.height)
                    attributes.append((attribute: .link(url: URL(string: link.url)!), frame: linkFrame))

                    if debug {
                        PDFGraphics.drawRect(rect: linkFrame, outline: .none, fill: UIColor.red.withAlphaComponent(0.4))
                    }
                }
            }
        }
    }

    /**
     Converts the instance variables `attributedText` or `simpleText` into a attributed string.
     If a simple text object is given, it will generate default string attributes.
     If a attributed text is given, it will return the attributed string instance

     - parameter generator: Generator, which holds font and text color data
     - parameter container: Container, where this text object is drawn

     - throws: PDFError.textObjectIsNil, if neither `simpleText` nor `attributedText` is set

     - returns: `NSAttributedString`, either created from `PDFAttributedTextObject.simpleText` or
     from extracted from `PDFAttributedTextObject.attributedText`
     */
    internal func generateAttributedText(generator: PDFGenerator, container: PDFContainer) throws -> NSAttributedString {
        if let simple = self.simpleText {
            let attributes = PDFAttributedTextObject.generateDefaultTextAttributes(
                container: container,
                fonts: &generator.fonts,
                textColor: &generator.textColor,
                spacing: simple.spacing,
                style: simple.style)

            return NSAttributedString(string: simple.text, attributes: attributes)
        } else if let attributedText = self.attributedText {
            return attributedText.text
        } else {
            throw PDFError.textObjectIsNil
        }
    }

    /**
     Creates the default text attributes, depending on the given `container`

     - parameter container: Container
     - parameter fonts: Reference to fonts per container
     - parameter textColor: Reference to text color per continaer
     - parameter spacing: Line spacing
     - parameter style: Optional style used to overrule generator settings

     - returns: Attributes dictionary, used for `NSAttributedString` creation
     */
    internal static func generateDefaultTextAttributes(container: PDFContainer,
                                                       fonts: inout [PDFContainer: UIFont],
                                                       textColor: inout [PDFContainer: UIColor],
                                                       spacing: CGFloat,
                                                       style: PDFTextStyle?) -> [NSAttributedString.Key: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        if container.isLeft {
            paragraphStyle.alignment = .left
        } else if container.isRight {
            paragraphStyle.alignment = .right
        } else {
            paragraphStyle.alignment = .center
        }
        paragraphStyle.lineSpacing = spacing

        return [
            NSAttributedString.Key.font: style?.font ?? fonts[container]!,
            NSAttributedString.Key.foregroundColor: style?.color ?? textColor[container]!,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
    }

    /**
     TODO: Documentation
     */
    override internal var copy: PDFRenderObject {
        return PDFAttributedTextObject(text: (self.attributedText ?? self.simpleText)!)
    }
}
