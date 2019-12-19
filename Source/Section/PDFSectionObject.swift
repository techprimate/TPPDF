//
//  PDFSectionObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
 TODO: Documentation
 */
internal class PDFSectionObject: PDFObject {

    /**
     TODO: Documentation
     */
    internal var section: PDFSection

    /**
     TODO: Documentation
     */
    internal init(section: PDFSection) {
        self.section = section
    }

    /**
     TODO: Documentation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        let originalIndent = generator.layout.indentation.content
        let originalContentOffset = generator.getContentOffset(in: container)

        var indentationLeft: CGFloat = 0.0
        var columnWidthSum: CGFloat = 0.0
        var objectsPerColumn: [Int: [(PDFContainer, PDFObject)]] = [:]

        let contentWidth = generator.document.layout.width
            - generator.layout.margin.left
            - generator.layout.margin.right

        for (columnIndex, column) in section.columns.enumerated() {
            columnWidthSum += column.width

            let columnLeftMargin = columnIndex == 0 ? 0 : section.columnMargin / 2
            let columnRightMargin = columnIndex == section.columns.count - 1 ? 0 : section.columnMargin / 2

            for container in [PDFContainer.contentLeft, .contentCenter, .contentRight] {
                generator.setContentOffset(in: container, to: originalContentOffset)
                generator.layout.indentation.setLeft(indentation: indentationLeft + columnLeftMargin, in: container)
                generator.layout.indentation.setRight(indentation: contentWidth
                    - columnWidthSum * contentWidth
                    + columnRightMargin, in: container)
            }

            let object = PDFSectionColumnObject(column: column)
            objectsPerColumn[columnIndex] = try object.calculate(generator: generator, container: container)

            indentationLeft += column.width * contentWidth
        }
        result += calulatePageBreakPositions(objectsPerColumn)
        generator.layout.indentation.content = originalIndent

        var contentMinY: CGFloat?
        var contentMaxY: CGFloat?

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
        let containsBreak = result.contains(where: { $0.1 is PDFPageBreakObject })
        generator.setContentOffset(in: container, to: (contentMaxY ?? 0) - (contentMinY ?? 0) + (containsBreak ? 0 : originalContentOffset))

        return result
    }

    /** The `PDFDocument` render engine calculates each object, which returns a list of calculated objects.
     As an example if you add a text object, it will be calculated and return one text object which will then be rendered.

     **BUT** if the text is too long to fit the space, then it will be split up into two text objects with a `PDFPageBreakObject` in-between.

     During the render process whenever a page break object is found, it will create a new pdf page and continue there.
     In order to render multi columns correctly, we need to merge the page breaks of all columns and make sure
     the page break occurs at the right time:

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
    internal func calulatePageBreakPositions(_ objectsPerColumn: [Int: [(PDFContainer, PDFObject)]]) -> [(PDFContainer, PDFObject)] {
        // stores how many objects are in one column at max
        let maxObjectsPerColumn = objectsPerColumn.reduce(0) { max($0, $1.value.count) }

        /* as soon as a column requests a page break, we need to stack subsequent objects of the very same column until the following is `true`:
         * one or more columns do not have more objects and all other columns, which have more objects left, are requesting a page break
         */
        var stackedObjectsPerColumn = [Int: [(PDFContainer, PDFObject)]]()
        for columnIndex in objectsPerColumn.keys {
            stackedObjectsPerColumn[columnIndex] = []
        }

        // stores the final objects which can be drawn to the pdf
        var result: [(PDFContainer, PDFObject)] = []

        // loop through all objects, row by row for each column
        for objectIndex in 0..<maxObjectsPerColumn {
            for (columnIndex, columnObjects) in objectsPerColumn where columnObjects.count > objectIndex {
                let columnObject = columnObjects[objectIndex]

                // if we already began to stack objects for this column, we simply put all subsequent objects onto the stack
                if var columnStack = stackedObjectsPerColumn[columnIndex], !columnStack.isEmpty {
                    columnStack.append(columnObject)
                    stackedObjectsPerColumn[columnIndex] = columnStack

                    // if the column is requesting a page break, we start stacking the objects
                } else if columnObject.1 is PDFPageBreakObject {
                    stackedObjectsPerColumn[columnIndex] = [columnObject]

                    // if the column does not have a stack and is not requesting a page break we just add the object to the result
                } else {
                    result += [columnObject]
                }
            }

            // does any of the columns request a page break?
            let isPageBreakNeeded = objectsPerColumn.keys.contains { columnIndex -> Bool in
                stackedObjectsPerColumn[columnIndex]?.first?.1 is PDFPageBreakObject
            }
            guard isPageBreakNeeded else { continue }

            // do all columns requesting a page break or if not, do they not contain any further objects?
            let isPageBreakAllowed = objectsPerColumn.keys.allSatisfy { columnIndex in
                stackedObjectsPerColumn[columnIndex]?.first?.1 is PDFPageBreakObject ||
                    (objectsPerColumn[columnIndex]?.count ?? 0) < objectIndex
            }
            guard isPageBreakAllowed else { continue }

            // we need to draw a page break now. For this we remove the first elements of all stacks
            // since these are the page breaks stored for each column
            for columnIndex in stackedObjectsPerColumn.keys {
                guard var columnStack = stackedObjectsPerColumn[columnIndex] else { continue }
                if columnStack.first?.1 is PDFPageBreakObject {
                    columnStack.removeFirst()
                }
                stackedObjectsPerColumn[columnIndex] = columnStack
            }

            // now we add one page break for all columns ...
            result += [(.contentLeft, PDFPageBreakObject())]

            // ... and process the stacked objects first
            result += calulatePageBreakPositions(stackedObjectsPerColumn)

            // now we can empty the column stacks and keep going
            // with the objects which still need to be processed
            for columnIndex in objectsPerColumn.keys {
                stackedObjectsPerColumn[columnIndex]?.removeAll()
            }
        }

        return result
    }

    /**
     Creates a new `PDFSectionObject` with the same properties
     */
    override internal var copy: PDFObject {
        return PDFSectionObject(section: self.section.copy)
    }
}
