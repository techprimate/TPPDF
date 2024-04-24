//
//  PDFSectionColumnObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

class PDFSectionColumnObject: PDFRenderObject {
    var column: PDFSectionColumn

    init(column: PDFSectionColumn) {
        self.column = column
    }

    /// nodoc
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        for (container, object) in column.objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        return result
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFSectionColumnObject(column: column.copy)
    }
}
