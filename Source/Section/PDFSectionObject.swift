//
//  PDFSectionObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

class PDFSectionObject: PDFObject {

	var section: PDFSection

	init(section: PDFSection) {
		self.section = section
	}

	override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
		var result: [(PDFContainer, PDFObject)] = []

		let originalIndent = generator.layout.indentation.content
		let originalContentOffset = generator.getContentOffset(in: container)

		var indentationLeft: CGFloat = 0.0
		var columnWidthSum: CGFloat = 0.0
		var objectsPerColumn: [Int: [(PDFContainer, PDFObject)]] = [:]

		for (columnIndex, column) in section.columns.enumerated() {
			columnWidthSum += column.width

			let columnLeftMargin = columnIndex == 0 ? 0 : section.columnMargin / 2
			let columnRightMargin = columnIndex == section.columns.count - 1 ? 0 : section.columnMargin / 2

			for container in [PDFContainer.contentLeft, .contentCenter, .contentRight] {
				generator.setContentOffset(in: container, to: originalContentOffset)
				generator.layout.indentation.setLeft(indentation: indentationLeft + columnLeftMargin, in: container)
				generator.layout.indentation.setRight(indentation: generator.document.layout.contentSize.width - columnWidthSum * generator.document.layout.contentSize.width + columnRightMargin, in: container)
			}

			let object = PDFSectionColumnObject(column: column)
			objectsPerColumn[columnIndex] = try object.calculate(generator: generator, container: container)

			indentationLeft += column.width * generator.document.layout.contentSize.width
		}
		result += calulatePageBreakPositions(objectsPerColumn)
		generator.layout.indentation.content = originalIndent

		var contentMinY: CGFloat? = nil
		var contentMaxY: CGFloat? = nil

		for current in result.reversed() {
			let currentObject = current.1

			if currentObject is PDFPageBreakObject {
				break
			}

			if contentMaxY == nil {
				contentMaxY = currentObject.frame.maxY
			} else if let maxY = contentMaxY, maxY < currentObject.frame.maxY {
				contentMaxY = currentObject.frame.maxY
			}

			if contentMinY == nil {
				contentMinY = currentObject.frame.minY
			} else if let minY = contentMaxY, minY > currentObject.frame.minY {
				contentMinY = currentObject.frame.minY
			}
		}
		generator.setContentOffset(in: container, to: (contentMaxY ?? 0) - (contentMinY ?? 0))

		return result
	}
	
	/** The `PDFDocument` render engine calculates each object, which returns a list of calculated objects.
	As an example if you add a text object, it will be calculated and return one text object which will then be rendered.
	
	**BUT** if the text is too long to fit the space, then it will be split up into two text objects with a `PDFPageBreakObject` in-between.
	
	During the render process whenever a page break object is found, it will create a new pdf page and continue there.
	In order to render multi columns correctly, we need to merge the page breaks of all columns and make sure the page break occurs at the right time:
	
	```
	All objects of column 1 before the first pagebreak
	All objects of column 2 before the first pagebreak
	All objects of column 3 before the first pagebreak
	Pagebreak
	All objects of column 1 after the first pagebreak up to the next pagebreak
	All objects of column 2 after the first pagebreak up to the next pagebreak
	All objects of column 3 after the first pagebreak up to the next pagebreak
	Pagebreak
	...
	```
	*/
	func calulatePageBreakPositions(_ objectsPerColumn: [Int: [(PDFContainer, PDFObject)]]) -> [(PDFContainer, PDFObject)] {
		let maxObjectsPerColumn = objectsPerColumn.reduce(0) { return max($0, $1.value.count) }

		var stackedObjectsPerColumn = [Int: [(PDFContainer, PDFObject)]]()
		for columnIndex in objectsPerColumn.keys {
			stackedObjectsPerColumn[columnIndex] = []
		}

		var result: [(PDFContainer, PDFObject)] = []
		for objectIndex in 0..<maxObjectsPerColumn {
			for (columnIndex, columnObjects) in objectsPerColumn where columnObjects.count > objectIndex {
				let columnObject = columnObjects[objectIndex]

				if var columnStack = stackedObjectsPerColumn[columnIndex], false == columnStack.isEmpty {
					columnStack.append(columnObject)
					stackedObjectsPerColumn[columnIndex] = columnStack

				} else if columnObject.1 is PDFPageBreakObject {
					stackedObjectsPerColumn[columnIndex] = [columnObject]

				} else {
					result += [columnObject]
				}
			}

			let isPageBreakNeeded = objectsPerColumn.keys.reduce(false) { isNeeded, columnIndex in
				return isNeeded || stackedObjectsPerColumn[columnIndex]?.first?.1 is PDFPageBreakObject
			}
			guard isPageBreakNeeded else { continue }

			let isPageBreakAllowed = objectsPerColumn.keys.reduce(true) { isAllowed, columnIndex in
				return isAllowed && (
					stackedObjectsPerColumn[columnIndex]?.first?.1 is PDFPageBreakObject ||
					(objectsPerColumn[columnIndex]?.count ?? 0) < objectIndex
				)
			}
			guard isPageBreakAllowed else { continue }

			for columnIndex in stackedObjectsPerColumn.keys {
				guard var columnStack = stackedObjectsPerColumn[columnIndex] else { continue }
				if columnStack.first?.1 is PDFPageBreakObject {
					columnStack.removeFirst()
				}
				stackedObjectsPerColumn[columnIndex] = columnStack
			}

			result += [(.contentLeft, PDFPageBreakObject())]
			result += calulatePageBreakPositions(stackedObjectsPerColumn)

			for columnIndex in objectsPerColumn.keys {
				stackedObjectsPerColumn[columnIndex]?.removeAll()
			}
		}

		return result
	}

	override var copy: PDFObject {
		return PDFSectionObject(section: self.section.copy)
	}
}
