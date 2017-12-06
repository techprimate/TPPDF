//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

// swiftlint:disable function_body_length

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

        var frames: [[(cell: CGRect, content: CGRect)]] = []

        let layout = generator.document.layout
        var availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        var origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)
        var startingPoint = origin

        // Calculate cells
        
        let cells = table.cells
        var pageBreakIndicies: [Int] = []

//        var headerCells: [[PDFTableCell]] = []
//
//        if cells.count > 0 {
//            headerCells = Array(table.cells.prefix(table.style.rowHeaderCount))
//        }

        for (rowIdx, row) in cells.enumerated() {
            let calculationResult = calculateFramesOfRow(row: row,
                                              rowIdx: rowIdx,
                                              availableSize: availableSize,
                                              origin: origin,
                                              layout: layout,
                                              tableHeight: cells.count,
                                              generator: generator)

            // Reposition in Y-Axis. This is for vertical alignment

            frames.append(calculationResult.frames)
            origin = calculationResult.newOrigin

            frames[rowIdx] = repositionRow(row: row, frames: calculationResult.frames)

            origin.x = startingPoint.x
            origin.y += (frames[rowIdx].map { return $0.cell.height }.max() ?? 0) + 2 * (table.margin)

            if origin.y > availableSize.height {
                pageBreakIndicies.append(rowIdx)

                try PDFPageBreakObject().calculate(generator: generator, container: container)

                availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
                origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)
                startingPoint = origin

                // add header cells
            }
        }

        // Create render objects
        return createRenderObjects(container: container,
                                   cells: cells,
                                   frames: frames,
                                   pageBreakIndicies: pageBreakIndicies)
    }

    func calculateFramesOfRow(row: [PDFTableCell],
                              rowIdx: Int,
                              availableSize: CGSize,
                              origin: CGPoint,
                              layout: PDFPageLayout,
                              tableHeight: Int,
                              generator: PDFGenerator) -> (frames: [(cell: CGRect, content: CGRect)], newOrigin: CGPoint) {
        var frames: [(cell: CGRect, content: CGRect)] = []
        var newOrigin = origin

        // Calcuate X, Y position and size
        for (colIdx, cell) in row.enumerated() {
            let columnWidth = table.widths[colIdx] * availableSize.width

            var frame = (
                cell: CGRect(
                    origin: newOrigin + table.margin,
                    size: CGSize(
                        width: columnWidth - 2 * table.margin,
                        height: 0
                    )
                ),
                content: CGRect(
                    origin: newOrigin + CGPoint(
                        x: table.margin + table.padding,
                        y: layout.space.header + table.margin + table.padding
                    ),
                    size: CGSize(
                        width: columnWidth - 2 * (table.margin + table.padding),
                        height: 0
                    )
                )
            )

            if let content = cell.content {
                let cellStyle = getCellStyle(offset: styleIndexOffset,
                                             position: cellPosition(offset: styleIndexOffset, row: rowIdx, column: colIdx),
                                             tableHeight: tableHeight,
                                             style: table.style,
                                             cell: cell)
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
                                                origin: frame.content.origin,
                                                width: frame.content.width,
                                                text: text,
                                                alignment: cell.alignment)
                    }
                } else if let image = content.imageValue {
                    result = PDFCalculations
                        .calculateCellFrame(generator: generator,
                                            origin: frame.content.origin,
                                            width: frame.content.width,
                                            image: image)
                }

                frame.content.size = result.size
                frame.cell.size.height = result.height + 2 * table.padding
            }

            frames.append(frame)

            newOrigin.x += columnWidth
        }
        return (frames, newOrigin)
    }

    func repositionRow(row: [PDFTableCell], frames originalFrames: [(cell: CGRect, content: CGRect)]) -> [(cell: CGRect, content: CGRect)] {
        var frames: [(cell: CGRect, content: CGRect)] = originalFrames

        let maxCellHeight: CGFloat = originalFrames.map { return $0.cell.height }.max() ?? 0

        for (colIdx, cell) in row.enumerated() {
            let alignment = cell.alignment
            let frame = originalFrames[colIdx]

            let contentX: CGFloat = {
                if alignment.isLeft {
                    return frame.content.minX
                } else if alignment.isRight {
                    return frame.content.maxX - table.padding - frame.content.width
                } else {
                    return frame.content.minX + (frame.cell.width - 2 * table.padding - frame.content.width) / 2
                }
            }()

            let contentY: CGFloat = {
                if alignment.isTop {
                    return frame.content.minY
                } else if alignment.isBottom {
                    return frame.content.minY + maxCellHeight - 2 * table.padding - frame.content.height
                } else {
                    return frame.content.minY + (maxCellHeight - 2 * table.padding - frame.content.height) / 2
                }
            }()

            frames[colIdx] = (
                cell: CGRect(x: frame.cell.minX, y: frame.cell.minY, width: frame.cell.width, height: maxCellHeight),
                content: CGRect(
                    origin: CGPoint(x: contentX, y: contentY),
                    size: frame.content.size)
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

        let attributes: [NSAttributedStringKey: AnyObject] = [
            NSAttributedStringKey.foregroundColor: cellStyle.colors.text,
            NSAttributedStringKey.font: cellStyle.font,
            NSAttributedStringKey.paragraphStyle: paragraph
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func createRenderObjects(container: PDFContainer,
                             cells: [[PDFTableCell]],
                             frames: [[(cell: CGRect, content: CGRect)]],
                             pageBreakIndicies: [Int]) -> [(PDFContainer, PDFObject)] {
        // Create render objects

        var result: [PDFObject?] = []

        for (rowIdx, row) in cells.enumerated() {
            for (colIdx, cell) in row.enumerated() {
                let cellStyle = getCellStyle(offset: styleIndexOffset,
                                             position: cellPosition(offset: styleIndexOffset, row: rowIdx, column: colIdx),
                                             tableHeight: cells.count,
                                             style: table.style,
                                             cell: cell)
                let cellFrame = frames[rowIdx][colIdx].cell
                let contentFrame = frames[rowIdx][colIdx].content

                // Background
                result.append(createCellBackgroundObject(cellStyle: cellStyle, frame: cellFrame))

                // Content
                result.append(createCellContentObject(content: cell.content, cellStyle: cellStyle, alignment: cell.alignment, frame: contentFrame))

                // Grid
                result += createCellOutlineObjects(borders: cellStyle.borders, cellFrame: cellFrame) as [PDFObject?]
            }

            // Page break
            if pageBreakIndicies.contains(rowIdx) {
                result.append(PDFPageBreakObject())
            }
        }

        //        let tableOutlineObject = PDFRectangleObject(lineStyle: table.style.outline, size: CGSize(width: self.frame.width, height: tableHeight))
        //        result.append((container, tableOutlineObject))

        return result.flatMap { (obj) -> (PDFContainer, PDFObject)? in
            if let obj = obj {
                return (container, obj)
            } else {
                return nil
            }
        }
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

    func cellPosition(offset: Int, row: Int, column: Int) -> PDFTableCellPosition {
        return PDFTableCellPosition(row: (row + offset), column: column)
    }

    func getCellStyle(offset: Int,
                      position: PDFTableCellPosition,
                      tableHeight: Int,
                      style: PDFTableStyle,
                      cell: PDFTableCell) -> PDFTableCellStyle {

        if let cellStyle = cell.style {
            return cellStyle
        }
        if position.row < style.columnHeaderCount || (position.row - offset < style.columnHeaderCount) {
            return style.columnHeaderStyle
        }
        if position.row > tableHeight + offset - style.footerCount {
            return style.footerStyle
        }
        if position.column < style.rowHeaderCount {
            return style.rowHeaderStyle
        }
        if (position.row - style.rowHeaderCount) % 2 == 1 {
            return style.alternatingContentStyle ?? style.contentStyle
        }

        return style.contentStyle
    }
}
