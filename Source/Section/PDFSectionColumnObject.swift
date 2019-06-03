//
//  PDFSectionColumnObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
 TODO: Documentation
 */
internal class PDFSectionColumnObject: PDFObject {

    /**
     TODO: Documentation
     */
	internal var column: PDFSectionColumn

    /**
     TODO: Documentation
     */
	internal init(column: PDFSectionColumn) {
		self.column = column
	}

    /**
     TODO: Documentation
     */
	override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
		var result: [(PDFContainer, PDFObject)] = []

		for (container, object) in column.objects {
			result += try object.calculate(generator: generator, container: container.contentContainer)
		}

		return result
	}

    /**
     Creates a new `PDFSectionColumnObject` with the same properties
     */
	override internal var copy: PDFObject {
		return PDFSectionColumnObject(column: self.column.copy)
	}
}
