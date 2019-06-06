//
//  PDFGroupObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

import Foundation
import UIKit

/**
 TODO: Documentation
 */
internal class PDFGroupObject: PDFObject {

    /**
     TODO: Documentation
     */
    internal var allowsBreaks: Bool

    /**
     TODO: Documentation
     */
    internal var objects: [(container: PDFGroupContainer, object: PDFObject)]

    /**
     TODO: Documentation
     */
    internal var isFullPage: Bool

    /**
     TODO: Documentation
     */
    internal var backgroundColor: UIColor?

    /**
     TODO: Documentation
     */
    internal var backgroundImage: PDFImage?

    /**
     TODO: Documentation
     */
    internal var backgroundShape: PDFDynamicGeometryShape?

    /**
     TODO: Documentation
     */
    internal var outline: PDFLineStyle

    /**
     TODO: Documentation
     */
    internal var padding: UIEdgeInsets

    /**
     TODO: Documentation
     */
    internal init(objects: [(container: PDFGroupContainer, object: PDFObject)],
                  allowsBreaks: Bool,
                  isFullPage: Bool,
                  backgroundColor: UIColor?,
                  backgroundImage: PDFImage?,
                  backgroundShape: PDFDynamicGeometryShape?,
                  outline: PDFLineStyle,
                  padding: UIEdgeInsets) {
        self.objects = objects
        self.allowsBreaks = allowsBreaks
        self.isFullPage = isFullPage
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.backgroundShape = backgroundShape
        self.outline = outline
        self.padding = padding
    }

    /**
     TODO: Documentation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        let heights = generator.layout.heights
        guard let columnState = generator.columnState.copy() as? PDFColumnLayoutState else {
            throw PDFError.copyingFailed
        }

        var pageBreakObject: PDFPageBreakObject?

        generator.layout.heights.add(padding.top, to: container)
        if PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container) < 0 {
            result += try PDFPageBreakObject().calculate(generator: generator, container: container)
        }
        result += [(container, self)]
        generator.currentPadding = padding

        for (container, object) in objects {
            let calcResult = try object.calculate(generator: generator, container: container.contentContainer)
            pageBreakObject = calcResult.first(where: { $0.1 is PDFPageBreakObject })?.1 as? PDFPageBreakObject

            if pageBreakObject != nil {
                break
            }
            result += calcResult
        }

        if isFullPage {
            self.frame = generator.document.layout.bounds.inset(by: UIEdgeInsets(top: generator.layout.margin.top,
                                                                                 left: generator.layout.margin.left,
                                                                                 bottom: generator.layout.margin.bottom,
                                                                                 right: generator.layout.margin.right))
        } else {
            self.frame = calculateFrame(objects: result)
        }
        generator.layout.heights.add(padding.bottom, to: container)
        generator.currentPadding = .zero

        guard let pbObj = pageBreakObject else {
            return result
        }

        generator.layout.heights = heights
        generator.columnState = columnState
        frame = CGRect.null

        result = []
        result += try pbObj.calculate(generator: generator, container: container)
        result += [(container, self)]

        generator.layout.heights.add(padding.top, to: container)
        generator.currentPadding = padding

        for (container, object) in objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        if isFullPage {
            self.frame = generator.document.layout.bounds.inset(by: UIEdgeInsets(top: generator.layout.margin.top,
                                                                                 left: generator.layout.margin.left,
                                                                                 bottom: generator.layout.margin.bottom,
                                                                                 right: generator.layout.margin.right))
        } else {
            self.frame = calculateFrame(objects: result)
        }
        generator.layout.heights.add(padding.bottom, to: container)
        generator.currentPadding = .zero

        return result
    }

    /**
     TODO: Documentation
     */
    private func calculateFrame(objects: [(container: PDFContainer, object: PDFObject)]) -> CGRect {
        let resultFrame = objects.reduce(CGRect.null, { (prev, arg) -> CGRect in
            if arg.object is PDFSpaceObject {
                var spaceFrame = arg.object.frame
                spaceFrame.size.width = 0
                return prev.union(spaceFrame)
            }
            if arg.object === self {
                return prev
            }
            return prev.union(arg.object.frame)
        })
        var paddedFrame = resultFrame
        paddedFrame.origin.y -= padding.top
        paddedFrame.size.height += (padding.top + padding.bottom)
        paddedFrame.origin.x -= padding.left
        paddedFrame.size.width += (padding.left + padding.right)
        return paddedFrame
    }

    /**
     TODO: Documentation
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer) throws {
        if let color = backgroundColor {
            let path = PDFGraphics.createRectPath(rect: self.frame, outline: self.outline)
            PDFGraphics.drawPath(path: path, outline: self.outline, fillColor: color)
        }
        if let shape = backgroundShape {
            PDFGraphics.drawPath(path: shape.path.bezierPath(in: self.frame),
                                 outline: shape.stroke,
                                 fillColor: shape.fillColor)
        }

        if generator.debug {
            PDFGraphics.drawRect(rect: self.frame, outline: PDFLineStyle(type: .dashed, color: .red, width: 1.0), fill: .clear)
            PDFGraphics.drawRect(rect: self.frame.inset(by: padding), outline: PDFLineStyle(type: .full, color: .purple, width: 1.0), fill: .clear)
        }
    }

    /**
     Creates a new `PDFGroupObject` with the same properties
     */
    override internal var copy: PDFObject {
        return PDFGroupObject(objects: self.objects.map { ($0, $1.copy) },
                              allowsBreaks: self.allowsBreaks,
                              isFullPage: self.isFullPage,
                              backgroundColor: self.backgroundColor,
                              backgroundImage: self.backgroundImage?.copy,
                              backgroundShape: self.backgroundShape,
                              outline: self.outline,
                              padding: self.padding)
    }
}
