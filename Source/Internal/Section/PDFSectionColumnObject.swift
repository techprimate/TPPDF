//
//  PDFSectionColumnObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
 TODO: Documentation
 */
class PDFSectionColumnObject: PDFRenderObject {
    /**
     TODO: Documentation
     */
    var column: PDFSectionColumn

    /**
     TODO: Documentation
     */
    init(column: PDFSectionColumn) {
        self.column = column
    }

    /**
     TODO: Documentation
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        for (container, object) in column.objects {
            result += try object.calculate(generator: generator, container: container.contentContainer)
        }

        return result
    }

    /**
     Creates a new `PDFSectionColumnObject` with the same properties
     */
    override var copy: PDFRenderObject {
        PDFSectionColumnObject(column: column.copy)
    }
}
