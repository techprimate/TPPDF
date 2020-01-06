//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

// swiftlint:disable function_parameter_count line_length

internal typealias PDFTableCalculatedCell = (cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))

/**
 TODO: Documentation
 */
internal class PDFTableObject: PDFRenderObject {

    /**
     Table to calculate and draw
     */
    internal var table: PDFTable

    /**
     Initializer

     - parameter: Table to calculate and draw
     */
    internal init(table: PDFTable) {
        self.table = table
    }

    /**
     TODO: Documentation
     */
    internal var styleIndexOffset: Int = 0

    /**
     - throws: `PDFError` if table validation fails. See `PDFTableValidator.validateTableData(::)` for details
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        try PDFTableValidator.validateTable(table: table)

        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        let tableOrigin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)

        let mergeNodes = PDFTableMergeUtil.calculateMerged(table: table)
        var verticalOrigins = [tableOrigin.y] + table.cells.indices.map { _ in tableOrigin.y }
        var cellItems: [[PDFTableCalculatedCell]] = []

        for (rowIdx, row) in mergeNodes.enumerated() {
            var frames: [PDFTableCalculatedCell] = []
            for node in row {
                let columns = node.position.column...(node.position.column + node.moreColumnsSpan)
                let originX = table.widths[..<node.position.column].reduce(0, +) * availableSize.width
                let origin = CGPoint(x: tableOrigin.x + originX,
                                     y: verticalOrigins[node.position.row])
                let availableWidth = table.widths[columns].reduce(0, +) * availableSize.width
                let style = getStyle(for: node, in: table, at: rowIdx)
                let frame = calculate(generator: generator,
                                      container: container,
                                      cell: node.cell,
                                      style: style,
                                      origin: origin,
                                      width: availableWidth)
                let bottomIndex = node.position.row + node.moreRowsSpan + 1
                verticalOrigins[bottomIndex] = max(verticalOrigins[bottomIndex], frame.frames.cell.maxY)

                frames.append(frame)
            }
            cellItems.append(frames)
        }

        // Iterate each row of merged cells
        for (rowIdx, row) in mergeNodes.enumerated() {
            // Iterate each merged cell
            for (colIdx, node) in row.enumerated() {
                var frame = cellItems[rowIdx][colIdx]
                // Align bottom border with other columns
                let bottomIndex = node.position.row + node.moreRowsSpan + 1
                let diffY = verticalOrigins[bottomIndex] - frame.frames.cell.maxY
                frame.frames.cell.size.height += diffY

                // Reposition cell content
                cellItems[rowIdx][colIdx] = reposition(cell: frame)
            }
        }

        // Create render objects
        let renderObjects = try createRenderObjects(generator: generator,
                                                    container: container,
                                                    cellItems: cellItems.reduce([], +))
        let finalOffset = PDFCalculations.calculateContentOffset(for: generator, of: renderObjects.offset, in: container)
        try PDFOffsetObject(offset: finalOffset).calculate(generator: generator, container: container)

        return renderObjects.objects
    }

    internal func calculate(generator: PDFGenerator,
                            container: PDFContainer,
                            cell: PDFTableCell,
                            style: PDFTableCellStyle,
                            origin: CGPoint,
                            width: CGFloat) -> PDFTableCalculatedCell {
        var frame = (
            cell: cell,
            style: style,
            frames: (
                cell: CGRect(
                    origin: origin + table.margin,
                    size: CGSize(
                        width: width - 2 * table.margin,
                        height: 0
                    )
                ),
                content: CGRect(
                    origin: origin + table.margin + table.padding,
                    size: CGSize(
                        width: width - 2 * (table.margin + table.padding),
                        height: 0
                    )
                )
            )
        )
        guard let content = cell.content else {
            return frame
        }

        let result = calculate(content: content,
                               style: style,
                               cell: cell,
                               generator: generator,
                               container: container,
                               contentOrigin: frame.frames.content.origin,
                               contentWidth: frame.frames.content.width)

        frame.frames.content.size = result.size
        frame.frames.cell.size.height = result.height + 2 * table.padding

        return frame
    }

    internal func calculate(content: PDFTableContent,
                            style: PDFTableCellStyle,
                            cell: PDFTableCell,
                            generator: PDFGenerator,
                            container: PDFContainer,
                            contentOrigin: CGPoint,
                            contentWidth: CGFloat) -> CGRect {
        if let text = getAttributedStringOfTable(content: content, style: style, alignment: cell.alignment) {
            return PDFCalculations
                .calculateCellFrame(generator: generator,
                                    container: container,
                                    position: (origin: contentOrigin, width: contentWidth),
                                    text: text,
                                    alignment: cell.alignment)
        }
        if let image = content.imageValue {
            return PDFCalculations
                .calculateCellFrame(generator: generator,
                                    origin: contentOrigin,
                                    width: contentWidth,
                                    image: image)
        }
        return CGRect.zero
    }

    internal func getAttributedStringOfTable(content: PDFTableContent,
                                             style: PDFTableCellStyle,
                                             alignment: PDFTableCellAlignment) -> NSAttributedString? {
        if let stringText = content.stringValue {
            return createAttributedCellText(text: stringText, cellStyle: style, alignment: alignment)
        }
        return content.attributedStringValue
    }

    /**
     TODO: Documentation
     */
    internal func reposition(cell: PDFTableCalculatedCell) -> PDFTableCalculatedCell {
        var result = cell

        result.frames.content.origin.x = repositionX(cell: cell)
        result.frames.content.origin.y = repositionY(cell: cell)

        return result
    }

    internal func repositionX(cell: PDFTableCalculatedCell) -> CGFloat {
        let alignment = cell.cell.alignment
        let frame = cell.frames

        if alignment.isLeft {
            return frame.content.minX
        }
        if alignment.isRight {
            return frame.content.minX + frame.cell.width - 2 * table.padding - frame.content.width
        }
        return frame.content.minX + (frame.cell.width - 2 * table.padding - frame.content.width) / 2
    }

    internal func repositionY(cell: PDFTableCalculatedCell ) -> CGFloat {
        let alignment = cell.cell.alignment
        let frame = cell.frames

        if alignment.isTop {
            return frame.content.minY
        }
        if alignment.isBottom {
            return frame.content.minY + frame.cell.height - 2 * table.padding - frame.content.height
        }
        return frame.content.minY + (frame.cell.height - 2 * table.padding - frame.content.height) / 2
    }

    /**
     TODO: Documentation
     */
    internal func createAttributedCellText(text: String, cellStyle: PDFTableCellStyle, alignment: PDFTableCellAlignment) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = {
            if alignment.isLeft {
                return .left
            }
            if alignment.isRight {
                return .right
            }
            return .center
        }()

        let attributes: [NSAttributedString.Key: AnyObject] = [
            .foregroundColor: cellStyle.colors.text,
            .font: cellStyle.font,
            .paragraphStyle: paragraph
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    /**
     TODO: Documentation
     */
    internal func createRenderObjects(generator: PDFGenerator,
                                      container: PDFContainer,
                                      cellItems: [PDFTableCalculatedCell]) throws -> (objects: [PDFLocatedRenderObject], offset: CGFloat) {
        var result: [PDFLocatedRenderObject] = []

        var pageStart: CGPoint! = nil
        var pageEnd: CGPoint = CGPoint.zero

        let layout = generator.layout
        let pageLayout = generator.document.layout
        let minOffset = layout.margin.top
            + layout.heights.maxHeaderHeight()
        let maxOffset = pageLayout.height
            - layout.margin.top
            - layout.heights.maxHeaderHeight()
        let contentHeight = maxOffset - minOffset

        var cells: [PDFTableCalculatedCell] = []
        var nextPageCells: [PDFTableCalculatedCell] = []

        for item in cellItems {
            let cellFrame = item.frames.cell
            if cellFrame.maxY < maxOffset {
                cells.append(item)
            } else {
                if cellFrame.minY < maxOffset {
                    cells.append(item)
                }
                var nextPageCell = item
                nextPageCell.frames.cell.origin.y -= contentHeight
                nextPageCell.frames.content.origin.y -= contentHeight
                nextPageCells.append(nextPageCell)
            }
        }

        for (idx, item) in cells.enumerated() {
            var cellFrame = item.frames.cell
            let contentFrame = item.frames.content

            if pageStart == nil {
                pageStart = cellFrame.origin - CGPoint(x: table.margin, y: table.margin)
            }
            pageEnd = CGPoint(x: cellFrame.maxX, y: cellFrame.maxY) + CGPoint(x: table.margin, y: table.margin)

            // Background
            var cellElements: [PDFRenderObject] = [createCellBackgroundObject(cellStyle: item.style, frame: cellFrame)]

            // Content
            if let contentObj = createCellContentObject(content: item.cell.content,
                                                        cellStyle: item.style,
                                                        alignment: item.cell.alignment,
                                                        frame: contentFrame) {
                cellElements.append(contentObj)
            }

            // Grid
            cellElements += createCellOutlineObjects(borders: item.style.borders, cellFrame: cellFrame)

            let sliceObject = PDFSlicedObject()
            sliceObject.children = cellElements
            sliceObject.frame = cellFrame
            if cellFrame.maxY > maxOffset {
                sliceObject.frame.size.height -= sliceObject.frame.maxY - maxOffset
                sliceObject.frame.size.height = min(sliceObject.frame.size.height, contentHeight)
            }
            if cellFrame.minY < minOffset {
                sliceObject.frame.origin.y += minOffset - sliceObject.frame.origin.y
                sliceObject.frame.size.height -= minOffset - sliceObject.frame.origin.y
            }
            result += try sliceObject.calculate(generator: generator, container: container)

            if nextPageCells.isEmpty && idx == cells.count - 1 {
                let tableOutlineObject = PDFRectangleObject(lineStyle: table.style.outline, size: CGSize.zero)
                tableOutlineObject.frame = CGRect(
                    x: pageStart.x,
                    y: pageStart.y,
                    width: pageEnd.x - pageStart.x,
                    height: pageEnd.y - pageStart.y
                )
                result += try tableOutlineObject.calculate(generator: generator, container: container)
            }
        }
        if !nextPageCells.isEmpty {
            result += try PDFPageBreakObject().calculate(generator: generator, container: container)
            let nestedResult = try createRenderObjects(generator: generator, container: container, cellItems: nextPageCells)
            return (objects: result + nestedResult.objects, offset: nestedResult.offset)
        }
        return (objects: result, offset: pageEnd.y)
    }

    /**
     TODO: Documentation
     */
    internal func createCellBackgroundObject(cellStyle: PDFTableCellStyle, frame: CGRect) -> PDFRenderObject {
        let object = PDFRectangleObject(lineStyle: .none, size: .zero, fillColor: cellStyle.colors.fill)
        object.frame = frame
        return object
    }

    /**
     TODO: Documentation
     */
    internal func createCellContentObject(content: PDFTableContent?,
                                          cellStyle: PDFTableCellStyle,
                                          alignment: PDFTableCellAlignment, frame: CGRect) -> PDFRenderObject? {
        guard let content = content else {
            return nil
        }
        var contentObject: PDFRenderObject?

        if let contentImage = content.imageValue {
            contentObject = PDFImageObject(image: PDFImage(image: contentImage, options: [.none]))
        } else {
            var attributedString: NSAttributedString?
            if let contentText = content.stringValue {
                attributedString = createAttributedCellText(text: contentText, cellStyle: cellStyle, alignment: alignment)
            } else if let contentText = content.attributedStringValue {
                attributedString = contentText
            }

            if let string = attributedString {
                let textObject = PDFAttributedTextObject(attributedText: PDFAttributedText(text: string))
                textObject.attributedString = string
                contentObject = textObject
            }
        }
        contentObject?.frame = frame

        return contentObject
    }

    /**
     TODO: Documentation
     */
    internal func createCellOutlineObjects(borders: PDFTableCellBorders, cellFrame: CGRect) -> [PDFLineObject] {
        return [
            PDFLineObject(style: borders.top,
                          startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                          endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.minY)),
            PDFLineObject(style: borders.bottom,
                          startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.maxY),
                          endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY)),
            PDFLineObject(style: borders.right,
                          startPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.minY),
                          endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY)),
            PDFLineObject(style: borders.left,
                          startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                          endPoint: CGPoint(x: cellFrame.minX, y: cellFrame.maxY))
        ]
    }

    internal func getStyle(for node: PDFTableNode, in table: PDFTable, at rowIdx: Int) -> PDFTableCellStyle {
        getStyle(for: node.cell,
                 tableStyle: table.style,
                 isHeader: rowIdx < table.style.columnHeaderCount,
                 isFooter: rowIdx >= table.cells.count - table.style.footerCount,
                 rowHeaderCount: table.style.rowHeaderCount,
                 isAlternatingRow: rowIdx % 2 == 1,
                 colIdx: node.position.column)
    }

    /**
     TODO: Documentation
     */
    internal func getStyle(for cell: PDFTableCell,
                           tableStyle: PDFTableStyle,
                           isHeader: Bool,
                           isFooter: Bool,
                           rowHeaderCount: Int,
                           isAlternatingRow: Bool,
                           colIdx: Int) -> PDFTableCellStyle {
        if let cellStyle = cell.style {
            return cellStyle
        } else if isHeader {
            return tableStyle.columnHeaderStyle
        } else if isFooter {
            return tableStyle.footerStyle
        } else if colIdx < rowHeaderCount {
            return tableStyle.rowHeaderStyle
        } else if isAlternatingRow {
            return tableStyle.alternatingContentStyle ?? tableStyle.contentStyle
        }
        return tableStyle.contentStyle
    }

    /**
     Creates a new `PDFTableObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        return PDFTableObject(table: table.copy)
    }
}
