//
//  PDFTableOfContentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

class PDFTableOfContentObject: PDFObject {

    var list: PDFList
    var options: PDFTableOfContent

    init(list: PDFList, options: PDFTableOfContent) {
        self.list = list
        self.options = options
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        result += try PDFListObject(list: list).calculate(generator: generator, container: container)

        return result
    }

    override var copy: PDFObject {
        return PDFListObject(list: self.list.copy)
    }
}
