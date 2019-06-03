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
class PDFTableOfContentObject: PDFObject {

    /**
     TODO: Documentation
     */
    var list: PDFList

    /**
     TODO: Documentation
     */
    var options: PDFTableOfContent

    /**
     TODO: Documentation
     */
    init(list: PDFList, options: PDFTableOfContent) {
        self.list = list
        self.options = options
    }

    /**
     TODO: Documentation
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        result += try PDFListObject(list: list).calculate(generator: generator, container: container)

        return result
    }

    /**
     TODO: Documentation
     */
    override var copy: PDFObject {
        return PDFListObject(list: self.list.copy)
    }
}
