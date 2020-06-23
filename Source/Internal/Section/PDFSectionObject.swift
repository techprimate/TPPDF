//
//  PDFSectionObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
internal class PDFSectionObject: PDFRenderObject {

    internal struct PDFSectionColumnMetadata {
        internal let minX: CGFloat
        internal let width: CGFloat
        internal let backgroundColor: Color?
    }

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
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        // Save state of layout
        let originalIndent = generator.layout.indentation.content
        let originalContentOffset = generator.getContentOffset(in: container)

        var leftColumnGuide: CGFloat = originalIndent.left
        var objectsPerColumn: [Int: [PDFLocatedRenderObject]] = [:]

        let availableWidth = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: container)
        let contentWidth = availableWidth - max(0, CGFloat(section.columns.count - 1)) * section.columnMargin

        var columnMetadata = [PDFSectionColumnMetadata]()
        for (columnIndex, column) in section.columns.enumerated() {
            let columnWidth = column.width * contentWidth
            let rightColumnGuide = leftColumnGuide + columnWidth

            for container in [PDFContainer.contentLeft, .contentCenter, .contentRight] {
                generator.setContentOffset(in: container, to: originalContentOffset)
                generator.layout.indentation.setLeft(indentation: leftColumnGuide, in: container)
                generator.layout.indentation.setRight(indentation: availableWidth - rightColumnGuide + originalIndent.right, in: container)
            }

            objectsPerColumn[columnIndex] = try PDFSectionColumnObject(column: column)
                .calculate(generator: generator, container: container)

            columnMetadata.append(.init(minX: generator.layout.margin.left + leftColumnGuide,
                                        width: columnWidth,
                                        backgroundColor: column.backgroundColor))

            leftColumnGuide = rightColumnGuide + section.columnMargin
        }
        result += calulatePageBreakPositions(objectsPerColumn, metadata: columnMetadata, container: container)
        generator.layout.indentation.content = originalIndent

        var contentMinY: CGFloat?
        var contentMaxY: CGFloat?

        for (_, currentObject) in result.reversed() {
            if currentObject is PDFPageBreakObject {
                break
            }
            if currentObject.frame.origin.y == CGFloat.infinity {
                continue
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
    internal func calulatePageBreakPositions(_ objectsPerColumn: [Int: [PDFLocatedRenderObject]], metadata: [PDFSectionColumnMetadata], container: PDFContainer) -> [PDFLocatedRenderObject] {
        // stores how many objects are in one column at max
        let maxObjectsPerColumn = objectsPerColumn.reduce(0) { max($0, $1.value.count) }

        /* as soon as a column requests a page break, we need to stack subsequent objects of the very same column until the following is `true`:
         * one or more columns do not have more objects and all other columns, which have more objects left, are requesting a page break
         */
        var stackedObjectsPerColumn = [Int: [PDFLocatedRenderObject]]()
        for columnIndex in objectsPerColumn.keys {
            stackedObjectsPerColumn[columnIndex] = []
        }

        // stores the final objects which can be drawn to the pdf
        var result: [PDFLocatedRenderObject] = []

        // loop through all objects, row by row for each column
        for objectIndex in 0..<maxObjectsPerColumn {
            // track the result elements per column, so we can calculate the section column frames
            var resultPerColumn = [Int: [PDFLocatedRenderObject]]()

            for (columnIndex, columnObjects) in objectsPerColumn where columnObjects.count > objectIndex {
                let columnObject = columnObjects[objectIndex]

                if var columnStack = stackedObjectsPerColumn[columnIndex], !columnStack.isEmpty {
                    // if we already began to stack objects for this column, we simply put all subsequent objects onto the stack
                    columnStack.append(columnObject)
                    stackedObjectsPerColumn[columnIndex] = columnStack
                } else if columnObject.1 is PDFPageBreakObject {
                    // if the column is requesting a page break, we start stacking the objects
                    stackedObjectsPerColumn[columnIndex] = [columnObject]
                } else {
                    // if the column does not have a stack and is not requesting a page break we just add the object to the result
                    resultPerColumn[columnIndex] = (resultPerColumn[columnIndex] ?? []) + [columnObject]
                }
            }

            // swiftlint:disable multiline_function_chains
            let allFrames = resultPerColumn.values.reduce([], +)
                .map(\.1.frame)
                .filter({ $0.origin != .null })
            if let sectionMinY = allFrames.map({ $0.minY }).min(),
                let sectionMaxY = allFrames.map({ $0.maxY }).max() {

                for (idx, columnObjects) in resultPerColumn {
                    let met = metadata[idx]
                    guard let backgroundColor = met.backgroundColor else {
                        result += columnObjects
                        continue
                    }
                    let frame = CGRect(x: met.minX, y: sectionMinY, width: met.width, height: sectionMaxY - sectionMinY)
                    let rect = PDFRectangleObject(lineStyle: .none, size: frame.size, fillColor: backgroundColor)
                    rect.frame = frame
                    result += [(container, rect)] + columnObjects
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
            result += calulatePageBreakPositions(stackedObjectsPerColumn, metadata: metadata, container: container)

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
    override internal var copy: PDFRenderObject {
        PDFSectionObject(section: self.section.copy)
    }
}
