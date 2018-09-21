//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

// swiftlint:disable function_body_length function_parameter_count line_length

class PDFTableObject: PDFObject {

    /**
     Table to calculate and draw
     */
    var table: PDFTable

    /**
     Initializer

     - parameter: Table to calculate and draw
     */
    init(table: PDFTable) {
        self.table = table
    }

    var styleIndexOffset: Int = 0

    /**
     - throws: `PDFError` if table validation fails. See `PDFTableValidator.validateTableData(::)` for details
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        try PDFTableValidator.validateTable(table: table)

        var cellItems: [[(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))]] = []

        var availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        var origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)

        // Calculate cells

        var pageBreakIndicies: [Int] = []
        var perPageIndex = 0

        var rowIdx = 0
        while rowIdx < table.cells.count {
            let row = table.cells[rowIdx]

            var styles: [PDFTableCellStyle] = stylesForRow(
                tableStyle: table.style,
                isHeader: perPageIndex < table.style.columnHeaderCount,
                isFooter: rowIdx >= table.cells.count - table.style.footerCount,
                rowHeaderCount: table.style.rowHeaderCount,
                isAlternatingRow: perPageIndex % 2 == 1,
                cells: row)

            // Calculate cell items
            let result = calculateRow(cells: row,
                                      rowIndex: rowIdx,
                                      availableSize: availableSize,
                                      origin: origin,
                                      styles: styles,
                                      generator: generator,
                                      container: container)

            let maxHeight = result.map { return $0.frames.cell.height }.max() ?? 0

            if maxHeight + table.margin <= availableSize.height {
                // Row can fit this page
                cellItems.append(result)
                perPageIndex += 1
                rowIdx += 1

                // Next row can also start on this page
                origin.y += maxHeight + table.margin
                availableSize.height -= maxHeight + table.margin
            } else {
                // Row needs to be on the next page
                // if one of the first header rows, then start whole table on next page
                if rowIdx < table.style.columnHeaderCount + 1 {
                    generator.layout.heights.content = 0
                    return [(container, PDFPageBreakObject())] + (try calculate(generator: generator, container: container))
                }

                generator.layout.heights.content = 0
                pageBreakIndicies.append(cellItems.count - 1)
                perPageIndex = 0

                availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
                origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)

                if table.showHeadersOnEveryPage {
                    var headerIndex = 0
                    while headerIndex < table.style.rowHeaderCount {
                        let cells = table.cells[headerIndex]

                        styles = stylesForRow(
                            tableStyle: table.style,
                            isHeader: true,
                            isFooter: false,
                            rowHeaderCount: table.style.rowHeaderCount,
                            isAlternatingRow: false,
                            cells: row)

                        let result = calculateRow(cells: cells,
                                                  rowIndex: headerIndex,
                                                  availableSize: availableSize,
                                                  origin: origin,
                                                  styles: styles,
                                                  generator: generator,
                                                  container: container)
                        cellItems.append(result)

                        let maxHeight = result.map { return $0.frames.cell.height }.max() ?? 0
                        origin.y += maxHeight + table.margin
                        availableSize.height -= maxHeight + table.margin

                        perPageIndex += 1

                        headerIndex += 1
                    }
                }
            }
        }

        // Create render objects
        let renderObjects = try createRenderObjects(generator: generator,
                                                container: container,
                                                cellItems: cellItems,
                                                pageBreakIndicies: pageBreakIndicies)
        let finalOffset = PDFCalculations.calculateContentOffset(for: generator, of: renderObjects.offset, in: container)
        try PDFOffsetObject(offset: finalOffset).calculate(generator: generator, container: container)

        return renderObjects.objects
    }

    func calculateRow(cells: [PDFTableCell],
                      rowIndex: Int,
                      availableSize: CGSize,
                      origin: CGPoint,
                      styles: [PDFTableCellStyle],
                      generator: PDFGenerator,
                      container: PDFContainer) -> [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))] {
        let calculationResult = calculateFrames(row: cells,
                                                rowIdx: rowIndex,
                                                availableSize: availableSize,
                                                origin: origin,
                                                tableHeight: table.cells.count,
                                                styles: styles,
                                                generator: generator,
                                                container: container)

        // Reposition in Y-Axis. This is for vertical alignment
        return repositionRow(row: cells, frames: calculationResult)
    }

    func calculateFrames(row: [PDFTableCell],
                         rowIdx: Int,
                         availableSize: CGSize,
                         origin: CGPoint,
                         tableHeight: Int,
                         styles: [PDFTableCellStyle],
                         generator: PDFGenerator,
                         container: PDFContainer) -> [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))] {
        var frames: [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))] = []
        var newOrigin = origin

        // Calcuate X, Y position and size
        for (colIdx, cell) in row.enumerated() {
            let columnWidth = table.widths[colIdx] * availableSize.width

            var frame = (
                cell: cell,
                style: styles[colIdx],
                frames: (
                    cell: CGRect(
                        origin: newOrigin + table.margin,
                        size: CGSize(
                            width: columnWidth - 2 * table.margin,
                            height: 0
                        )
                    ),
                    content: CGRect(
                        origin: newOrigin + table.margin + table.padding,
                        size: CGSize(
                            width: columnWidth - 2 * (table.margin + table.padding),
                            height: 0
                        )
                    )
                )
            )

            if let content = cell.content {
                let cellStyle = styles[colIdx]
                var result = CGRect.zero

                if content.isAttributedString || content.isString {
                    let text: NSAttributedString! = {
                        if let attributedString = content.attributedStringValue {
                            return attributedString
                        } else if let text = content.stringValue {
                            return createAttributedCellText(text: text, cellStyle: cellStyle, alignment: cell.alignment)
                        } else {
                            return nil
                        }
                    }()
                    if text != nil {
                        result = PDFCalculations
                            .calculateCellFrame(generator: generator,
                                                container: container,
                                                position: (origin: frame.frames.content.origin, width: frame.frames.content.width),
                                                text: text,
                                                alignment: cell.alignment)
                    }
                } else if let image = content.imageValue {
                    result = PDFCalculations
                        .calculateCellFrame(generator: generator,
                                            origin: frame.frames.content.origin,
                                            width: frame.frames.content.width,
                                            image: image)
                }

                frame.frames.content.size = result.size
                frame.frames.cell.size.height = result.height + 2 * table.padding
            }

            frames.append(frame)

            newOrigin.x += columnWidth
        }
        return frames
    }

    func repositionRow(row: [PDFTableCell], frames originalFrames: [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))]) -> [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))] {
        var frames: [(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))] = originalFrames

        let maxCellHeight: CGFloat = originalFrames.map { return $0.frames.cell.height }.max() ?? 0

        for (colIdx, cell) in row.enumerated() {
            let alignment = cell.alignment
            let frame = originalFrames[colIdx]

            let contentX: CGFloat = {
                if alignment.isLeft {
                    return frame.frames.content.minX
                } else if alignment.isRight {
                    return frame.frames.content.minX + frame.frames.cell.width - 2 * table.padding - frame.frames.content.width
                } else {
                    return frame.frames.content.minX + (frame.frames.cell.width - 2 * table.padding - frame.frames.content.width) / 2
                }
            }()

            let contentY: CGFloat = {
                if alignment.isTop {
                    return frame.frames.content.minY
                } else if alignment.isBottom {
                    return frame.frames.content.minY + maxCellHeight - 2 * table.padding - frame.frames.content.height
                } else {
                    return frame.frames.content.minY + (maxCellHeight - 2 * table.padding - frame.frames.content.height) / 2
                }
            }()

            frames[colIdx].frames = (
                cell: CGRect(x: frame.frames.cell.minX, y: frame.frames.cell.minY, width: frame.frames.cell.width, height: maxCellHeight),
                content: CGRect(
                    origin: CGPoint(x: contentX, y: contentY),
                    size: frame.frames.content.size)
            )
        }

        return frames
    }

    func createAttributedCellText(text: String, cellStyle: PDFTableCellStyle, alignment: PDFTableCellAlignment) -> NSAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = {
            if alignment.isLeft {
                return NSTextAlignment.left
            } else if alignment.isRight {
                return NSTextAlignment.right
            } else {
                return NSTextAlignment.center
            }
        }()

        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.foregroundColor: cellStyle.colors.text,
            NSAttributedString.Key.font: cellStyle.font,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func createRenderObjects(generator: PDFGenerator,
                             container: PDFContainer,
                             cellItems: [[(cell: PDFTableCell, style: PDFTableCellStyle, frames: (cell: CGRect, content: CGRect))]],
                             pageBreakIndicies: [Int]) throws -> (objects: [(PDFContainer, PDFObject)], offset: CGFloat) {
        var result: [PDFObject?] = []

        var pageStart: CGPoint! = nil
        var pageEnd: CGPoint = CGPoint.zero

        for (rowIdx, row) in cellItems.enumerated() {
            for item in row {
                let cellFrame = item.frames.cell
                let contentFrame = item.frames.content

                if pageStart == nil {
                    pageStart = cellFrame.origin - CGPoint(x: table.margin, y: table.margin)
                }
                pageEnd = CGPoint(x: cellFrame.maxX, y: cellFrame.maxY) + CGPoint(x: table.margin, y: table.margin)

                // Background
                result.append(createCellBackgroundObject(cellStyle: item.style,
                                                         frame: cellFrame))

                // Content
                result.append(createCellContentObject(content: item.cell.content,
                                                      cellStyle: item.style,
                                                      alignment: item.cell.alignment,
                                                      frame: contentFrame))

                // Grid
                result += createCellOutlineObjects(borders: item.style.borders, cellFrame: cellFrame) as [PDFObject?]
            }

            if pageBreakIndicies.contains(rowIdx) || rowIdx == cellItems.count - 1 {
                let tableOutlineObject = PDFRectangleObject(lineStyle: table.style.outline, size: CGSize.zero)
                tableOutlineObject.frame = CGRect(
                    x: pageStart.x,
                    y: pageStart.y,
                    width: pageEnd.x - pageStart.x,
                    height: pageEnd.y - pageStart.y
                )
                result.append(tableOutlineObject)
            }

            // Page break
            if pageBreakIndicies.contains(rowIdx) {
                result.append(PDFPageBreakObject())

                pageStart = nil
            }
        }

        let compactObjects = result.compactMap { (obj) -> (PDFContainer, PDFObject)? in
            if let obj = obj {
                return (container, obj)
            } else {
                return nil
            }
        }
        return (objects: compactObjects, offset: pageEnd.y)
    }

    func createCellBackgroundObject(cellStyle: PDFTableCellStyle, frame: CGRect) -> PDFObject {
        let object = PDFRectangleObject(lineStyle: .none, size: .zero, fillColor: cellStyle.colors.fill)
        object.frame = frame
        return object
    }

    func createCellContentObject(content: PDFTableContent?,
                                 cellStyle: PDFTableCellStyle,
                                 alignment: PDFTableCellAlignment, frame: CGRect) -> PDFObject? {
        if content == nil {
            return nil
        }
        var contentObject: PDFObject?

        if let contentImage = content?.imageValue {
            contentObject = PDFImageObject(image: PDFImage(image: contentImage))
        } else {
            var attributedString: NSAttributedString?
            if let contentText = content?.stringValue {
                attributedString = createAttributedCellText(text: contentText, cellStyle: cellStyle, alignment: alignment)
            } else if let contentText = content?.attributedStringValue {
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

    func createCellOutlineObjects(borders: PDFTableCellBorders, cellFrame: CGRect) -> [PDFLineObject] {
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

    func stylesForRow(tableStyle: PDFTableStyle,
                      isHeader: Bool,
                      isFooter: Bool,
                      rowHeaderCount: Int,
                      isAlternatingRow: Bool,
                      cells: [PDFTableCell]) -> [PDFTableCellStyle] {
        var result: [PDFTableCellStyle] = []

        for (idx, cell) in cells.enumerated() {
            var style: PDFTableCellStyle = tableStyle.contentStyle

            if let cellStyle = cell.style {
                style = cellStyle
            } else if isHeader {
                style = tableStyle.columnHeaderStyle
            } else if isFooter {
                style = tableStyle.footerStyle
            } else if idx < rowHeaderCount {
                style = tableStyle.rowHeaderStyle
            } else if isAlternatingRow {
                style = tableStyle.alternatingContentStyle ?? tableStyle.contentStyle
            }

            result.append(style)
        }

        return result
    }

    override var copy: PDFObject {
        return PDFTableObject(table: table.copy)
    }
}
