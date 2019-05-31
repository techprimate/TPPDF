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

    /**
     TODO: Documentation
     */
    init(allowsBreaks: Bool, objects: [(container: PDFGroupContainer, object: PDFObject)]) {
        self.allowsBreaks = allowsBreaks
        self.objects = objects
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
        guard let pbObj = pageBreakObject else {
            return result
        }

        generator.layout.heights = heights
        generator.columnState = columnState

        result = [(container, self)]
        result += try pbObj.calculate(generator: generator, container: container)
        for (container, object) in objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        self.frame = result.reduce(CGRect.zero, { (prev, arg) -> CGRect in prev.union(arg.1.frame) })

        return result
    }

    /**
     Creates a new `PDFGroupObject` with the same properties
     */
    override var copy: PDFObject {
        return PDFGroupObject(allowsBreaks: self.allowsBreaks, objects: objects.map { ($0, $1.copy)})
    }
}

