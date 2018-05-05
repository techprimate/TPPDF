//
//  PDFSectionColumnObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

class PDFSectionColumnObject: PDFObject {

	var column: PDFSectionColumn

	init(column: PDFSectionColumn) {
		self.column = column
	}

	override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
		var result: [(PDFContainer, PDFObject)] = []

		for (container, object) in column.objects {
			result += try object.calculate(generator: generator, container: container.contentContainer)
		}

		return result
	}

	override var copy: PDFObject {
		return PDFSectionColumnObject(column: self.column.copy)
	}
}
