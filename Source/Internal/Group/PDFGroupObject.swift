//
//  PDFGroupObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
/**
 TODO: Documentation
 */
internal class PDFGroupObject: PDFRenderObject {

    /**
     TODO: Documentation
     */
    internal var allowsBreaks: Bool

    /**
     TODO: Documentation
     */
    internal var objects: [(container: PDFGroupContainer, object: PDFRenderObject)]

    /**
     TODO: Documentation
     */
    internal var isFullPage: Bool

    /**
     TODO: Documentation
     */
    internal var backgroundColor: Color?

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
    internal var padding: EdgeInsets

    /**
     TODO: Documentation
     */
    internal init(objects: [(container: PDFGroupContainer, object: PDFRenderObject)],
                  allowsBreaks: Bool,
                  isFullPage: Bool,
                  backgroundColor: Color?,
                  backgroundImage: PDFImage?,
                  backgroundShape: PDFDynamicGeometryShape?,
                  outline: PDFLineStyle,
                  padding: EdgeInsets) {
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
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        let heights = generator.layout.heights
        guard let columnState = generator.columnState.copy() as? PDFColumnLayoutState else {
            throw PDFError.copyingFailed
        }
        let cPadding = generator.currentPadding

        // Top Padding
        generator.layout.heights.add(padding.top, to: container)

        // Fix if not enough space left
        var result: [PDFLocatedRenderObject] = []
        if PDFCalculations.calculateAvailableFrameHeight(for: generator, in: container) < 0 {
            result += try PDFPageBreakObject().calculate(generator: generator, container: container)
        }

        var groupedResult = [
            [PDFLocatedRenderObject]()
        ]

        // Set padding
        generator.currentPadding = padding

        // Calculate content
        for arg in objects {
            let (groupContainer, object) = arg
            let calcResult = try object.calculate(generator: generator, container: groupContainer.contentContainer)

            for calResult in calcResult {
                groupedResult[groupedResult.count - 1].append(calResult)
                if calResult.1 is PDFPageBreakObject {
                    groupedResult.append([])
                }
            }

            // Check for page breaks
            let pageBreaks: [(Int, PDFPageBreakObject)] = calcResult.enumerated()
                .compactMap({ ($0.offset, $0.element.1 as? PDFPageBreakObject) })
                .compactMap({ $0.1 == nil ? nil : ($0.0, $0.1!) })

            if pageBreaks.count == 1 && !allowsBreaks { // If one pagebreak, start group on next page.
                generator.layout.heights = heights
                generator.columnState = columnState
                return try calculateOnNextPage(generator: generator, container: container, pbObj: pageBreaks[0].1)
            }
        }

        for (idx, grouped) in groupedResult.enumerated() {
            let group = idx == 0 ? self : PDFGroupObject(objects: [],
                                                         allowsBreaks: allowsBreaks,
                                                         isFullPage: isFullPage,
                                                         backgroundColor: backgroundColor,
                                                         backgroundImage: backgroundImage,
                                                         backgroundShape: backgroundShape,
                                                         outline: outline,
                                                         padding: padding)

            group.frame = isFullPage ? calculateBoundsFrame(generator: generator) : calculateFrame(objects: grouped)
            result.append((container, group))
            result += grouped
        }

        generator.layout.heights.add(padding.bottom, to: container)
        generator.currentPadding = cPadding

        return result
    }

    private func calculateOnNextPage(generator: PDFGenerator,
                                     container: PDFContainer,
                                     pbObj: PDFPageBreakObject) throws -> [PDFLocatedRenderObject] {
        frame = CGRect.null

        var result: [PDFLocatedRenderObject] = []
        result += try pbObj.calculate(generator: generator, container: container)
        result += [(container, self)]

        generator.layout.heights.add(padding.top, to: container)
        generator.currentPadding = padding

        for (container, object) in objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        self.frame  = isFullPage ? calculateBoundsFrame(generator: generator) : calculateFrame(objects: result)
        generator.layout.heights.add(padding.bottom, to: container)
        return result
    }

    private func calculateBoundsFrame(generator: PDFGenerator) -> CGRect {
        generator.document.layout.bounds.inset(by: generator.layout.margin)
    }

    /**
     TODO: Documentation
     */
    private func calculateFrame(objects: [(container: PDFContainer, object: PDFRenderObject)]) -> CGRect {
        var resultFrame = CGRect.null
        for arg in objects {
            if arg.object is PDFSpaceObject {
                var spaceFrame = arg.object.frame
                spaceFrame.size.width = 0
                resultFrame = resultFrame.union(spaceFrame)
                continue
            }
            if arg.object === self || arg.object is PDFPageBreakObject {
                continue
            }
            resultFrame = resultFrame.union(arg.object.frame)
        }
        resultFrame.origin.y -= padding.top
        resultFrame.size.height += (padding.top + padding.bottom)
        resultFrame.origin.x -= padding.left
        resultFrame.size.width += (padding.left + padding.right)
        return resultFrame
    }

    /**
     TODO: Documentation
     */
    override internal func draw(generator: PDFGenerator, container: PDFContainer, in context: PDFContext) throws {
        if let color = backgroundColor {
            PDFGraphics.drawRect(in: context, rect: self.frame, outline: self.outline, fill: color)
        }
        if let shape = backgroundShape {
            PDFGraphics.drawPath(path: shape.path.bezierPath(in: self.frame),
                                 in: context,
                                 outline: shape.stroke,
                                 fillColor: shape.fillColor)
        }

        if generator.debug {
            PDFGraphics.drawRect(in: context,
                                 rect: self.frame,
                                 outline: PDFLineStyle(type: .dashed, color: .red, width: 1.0), fill: .clear)
            PDFGraphics.drawRect(in: context,
                                 rect: self.frame.inset(by: padding),
                                 outline: PDFLineStyle(type: .full, color: .purple, width: 1.0), fill: .clear)
        }
        applyAttributes(in: context)
    }

    /**
     Creates a new `PDFGroupObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFGroupObject(objects: self.objects.map { ($0, $1.copy) },
                       allowsBreaks: self.allowsBreaks,
                       isFullPage: self.isFullPage,
                       backgroundColor: self.backgroundColor,
                       backgroundImage: self.backgroundImage?.copy,
                       backgroundShape: self.backgroundShape,
                       outline: self.outline,
                       padding: self.padding)
    }
}
