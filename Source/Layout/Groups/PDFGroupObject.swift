//
//  PDFGroupObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
class PDFGroupObject: PDFObject {

    /**
     TODO: Documentation
     */
    var allowsBreaks: Bool

    /**
     TODO: Documentation
     */
    var objects: [(container: PDFGroupContainer, object: PDFObject)]

    var backgroundColor: UIColor?

    /**
     TODO: Documentation
     */
    init(allowsBreaks: Bool, objects: [(container: PDFGroupContainer, object: PDFObject)], backgroundColor: UIColor?) {
        self.allowsBreaks = allowsBreaks
        self.objects = objects
        self.backgroundColor = backgroundColor
    }

    /**
     TODO: Documentation
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = [(container, self)]

        let heights = generator.layout.heights
        guard let columnState = generator.columnState.copy() as? PDFColumnLayoutState else {
            throw PDFError.copyingFailed
        }

        var pageBreakObject: PDFPageBreakObject?

        for (container, object) in objects {
            let calcResult = try object.calculate(generator: generator, container: container.contentContainer)
            pageBreakObject = calcResult.first(where: { $0.1 is PDFPageBreakObject })?.1 as? PDFPageBreakObject

            if pageBreakObject != nil {
                break
            }
            result += calcResult
        }

        self.frame = calculateFrame(objects: result)

        guard let pbObj = pageBreakObject else {
            return result
        }

        generator.layout.heights = heights
        generator.columnState = columnState
        frame = CGRect.null

        result = [(container, self)]
        result += try pbObj.calculate(generator: generator, container: container)

        for (container, object) in objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        self.frame = calculateFrame(objects: result)

        return result
    }

    private func calculateFrame(objects: [(container: PDFContainer, object: PDFObject)]) -> CGRect {
        return objects.reduce(CGRect.null, { (prev, arg) -> CGRect in
            if arg.object is PDFSpaceObject {
                var spaceFrame = arg.object.frame
                spaceFrame.size.width = 0
                return prev.union(spaceFrame)
            }
            return prev.union(arg.object.frame)
        })
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        guard let backgroundColor = backgroundColor else {
            return
        }
        PDFGraphics.drawRect(rect: self.frame,
                             outline: .none, fill: backgroundColor)
    }

    /**
     Creates a new `PDFGroupObject` with the same properties
     */
    override var copy: PDFObject {
        return PDFGroupObject(allowsBreaks: self.allowsBreaks,
                              objects: self.objects.map { ($0, $1.copy)},
                              backgroundColor: self.backgroundColor)
    }
}

