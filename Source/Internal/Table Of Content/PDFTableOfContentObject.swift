//
//  PDFTableOfContentObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

class PDFTableOfContentObject: PDFRenderObject {
    var list: PDFList
    var options: PDFTableOfContent

    init(list: PDFList, options: PDFTableOfContent) {
        self.list = list
        self.options = options
    }

    /// nodoc
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        result += try PDFListObject(list: list).calculate(generator: generator, container: container)

        return result
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFListObject(list: list.copy)
    }
}
