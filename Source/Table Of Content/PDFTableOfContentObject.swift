//
//  PDFTableOfContentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
internal class PDFTableOfContentObject: PDFObject {

    /**
     TODO: Documentation
     */
    internal var list: PDFList

    /**
     TODO: Documentation
     */
    internal var options: PDFTableOfContent

    /**
     TODO: Documentation
     */
    internal init(list: PDFList, options: PDFTableOfContent) {
        self.list = list
        self.options = options
    }

    /**
     TODO: Documentation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        result += try PDFListObject(list: list).calculate(generator: generator, container: container)

        return result
    }

    /**
     TODO: Documentation
     */
    override internal var copy: PDFObject {
        return PDFListObject(list: self.list.copy)
    }
}
