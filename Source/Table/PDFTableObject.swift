//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

// swiftlint:disable cyclomatic_complexity function_body_length

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

        /// All outer cell frame
        var cellFrames: [[CGRect]] = []
        /// All Inner content cell frame
        var contentFrames: [[CGRect]] = []
        
        styleIndexOffset = 0

        let layout = generator.document.layout
        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        var origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)

        self.frame = CGRect(x: origin.x, y: origin.y, width: availableSize.width, height: 0)
        
        // Calculate cells
        
        let cells = table.cells
        var tableHeight: CGFloat = 0

        for (rowIdx, row) in cells.enumerated() {
            contentFrames.append([])
            cellFrames.append([])
            
            // Calcuate X, Y position and size
            for (colIdx, cell) in row.enumerated() {
                let columnWidth = table.widths[colIdx] * availableSize.width
                let cellWidth = columnWidth - 2 * table.margin
                let contentWidth = cellWidth - 2 * table.padding
                
                let contentPosition = origin + CGPoint(
                    x: table.margin + table.padding,
                    y: layout.space.header + table.margin + table.padding
                )
                
                var contentFrame = CGRect(
                    origin: contentPosition,
                    size: CGSize(width: contentWidth, height: 0)
                )
                var cellFrame = CGRect(
                    origin: origin + table.margin,
                    size: CGSize(width: cellWidth, height: 0)
                )
                
                if let content = cell.content {
                    let cellStyle = getCellStyle(offset: styleIndexOffset,
                                                 position: cellPosition(offset: styleIndexOffset, row: rowIdx, column: colIdx),
                                                 tableHeight: cells.count,
                                                 style: table.style,
                                                 cell: cell
                    )
                    var result = CGRect.zero
                    
                    switch content.content {
                    case let text as String:
                        let paragraph = NSMutableParagraphStyle()
                        paragraph.alignment = {
                            if cell.alignment.isLeft {
                                return NSTextAlignment.left
                            } else if cell.alignment.isRight {
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
                        let attributedText = NSAttributedString(string: text, attributes: attributes)
                        result = PDFCalculations.calculateCellFrame(generator: generator,
                                                                    origin: contentPosition,
                                                                    width: contentWidth,
                                                                    text: attributedText,
                                                                    alignment: cell.alignment)
                    case let text as NSAttributedString:
                        result = PDFCalculations.calculateCellFrame(generator: generator,
                                                                    origin: contentPosition,
                                                                    width: contentWidth,
                                                                    text: text,
                                                                    alignment: cell.alignment)
                    case let image as UIImage:
                        result = PDFCalculations.calculateCellFrame(generator: generator,
                                                                    origin: contentPosition,
                                                                    width: contentWidth,
                                                                    image: image)
                    default:
                        break
                    }
                    
                    contentFrame.size = result.size
                    cellFrame.size.height = result.height + 2 * table.padding
                }
                
                contentFrames[rowIdx].append(contentFrame)
                cellFrames[rowIdx].append(cellFrame)
                
                origin.x += columnWidth
            }
            
            // Reposition in Y-Axis. This is for vertical alignment
            
            let maxCellHeight: CGFloat = cellFrames[rowIdx].map { return $0.height }.max() ?? 0
            
            for (colIdx, cell) in row.enumerated() {
                let alignment = cell.alignment
                let cellFrame = cellFrames[rowIdx][colIdx]
                let contentFrame = contentFrames[rowIdx][colIdx]
                
                let contentX: CGFloat = {
                    if alignment.isLeft {
                        return contentFrame.minX
                    } else if alignment.isRight {
                        return contentFrame.maxX - table.padding - contentFrame.width
                    } else {
                        return contentFrame.minX + (cellFrame.width - 2 * table.padding - contentFrame.width) / 2
                    }
                }()
                
                let contentY: CGFloat = {
                    if alignment.isTop {
                        return contentFrame.minY
                    } else if alignment.isBottom {
                        return contentFrame.minY + maxCellHeight - 2 * table.padding - contentFrame.height
                    } else {
                        return contentFrame.minY + (maxCellHeight - 2 * table.padding - contentFrame.height) / 2
                    }
                }()
                
                contentFrames[rowIdx][colIdx].origin.x = contentX
                contentFrames[rowIdx][colIdx].origin.y = contentY
                cellFrames[rowIdx][colIdx].size.height = maxCellHeight
            }
            
            origin.x = frame.minX
            origin.y += maxCellHeight + 2 * (table.margin)
            tableHeight = origin.y
        }
        
        var result: [(PDFContainer, PDFObject)] = []

        for (rowIdx, row) in cells.enumerated() {
            for (colIdx, cell) in row.enumerated() {
                let cellStyle = getCellStyle(offset: styleIndexOffset,
                                             position: cellPosition(offset: styleIndexOffset, row: rowIdx, column: colIdx),
                                             tableHeight: cells.count,
                                             style: table.style,
                                             cell: cell)
                let cellFrame = cellFrames[rowIdx][colIdx]
                let contentFrame = contentFrames[rowIdx][colIdx]

                // Background

                let object = PDFRectangleObject(lineStyle: .none, size: .zero, fillColor: cellStyle.colors.fill)
                object.frame = cellFrame

                result.append((container, object))

                // Content

                var contentObject: PDFObject?

                if let contentImage = cell.content?.imageValue {
                    contentObject = PDFImageObject(image: PDFImage(image: contentImage))
                } else if let contentText = cell.content?.stringValue {
                    let attributes: [NSAttributedStringKey: AnyObject] = [
                        NSAttributedStringKey.foregroundColor: cellStyle.colors.text,
                        NSAttributedStringKey.font: cellStyle.font
                    ]

                    let string = NSAttributedString(string: contentText, attributes: attributes)
                    let textObject = PDFAttributedTextObject(attributedText:
                        PDFAttributedText(text: string))
                    textObject.attributedString = string
                    contentObject = textObject
                } else if let contentText = cell.content?.attributedStringValue {
                    let textObject = PDFAttributedTextObject(attributedText: PDFAttributedText(text: contentText))
                    textObject.attributedString = contentText
                    contentObject = textObject
                }

                if let obj = contentObject {
                    obj.frame = contentFrame
                    result.append((container, obj))
                }

                // Grid

                let lineObjects = [
                    PDFLineObject(style: cellStyle.borders.top,
                                  startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                                  endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.minY)),
                    PDFLineObject(style: cellStyle.borders.bottom,
                                  startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.maxY),
                                  endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY)),
                    PDFLineObject(style: cellStyle.borders.right,
                                  startPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.minY),
                                  endPoint: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY)),
                    PDFLineObject(style: cellStyle.borders.left,
                                  startPoint: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                                  endPoint: CGPoint(x: cellFrame.minX, y: cellFrame.maxY))
                    ]
                for line in lineObjects {
                    result.append((container, line))
                }
            }
        }

        let tableOutlineObject = PDFRectangleObject(lineStyle: table.style.outline, size: CGSize(width: self.frame.width, height: tableHeight))
        result.append((container, tableOutlineObject))

        return result
    }

//    func debugDraw(page: PDFTablePageObject) {
//        let debugGridStyle = PDFLineStyle(type: .full, color: UIColor.red, width: 1.0)
//        let debugCellStyle = PDFLineStyle(type: .full, color: UIColor.green, width: 1.0)
//        let debugCellContentStyle = PDFLineStyle(type: .full, color: UIColor.blue, width: 1.0)
//
//        var x: CGFloat = frame.minX
//        for width in [0] + table.widths {
//            x += width * frame.width
//            PDFGraphics.drawLine(start: CGPoint(x: x, y: frame.minY), end: CGPoint(x: x, y: frame.maxY), style: debugGridStyle)
//        }
//
//        var y: CGFloat = frame.minY
//        for height in [0] + page.rows.map { return $0.height } {
//            y += height
//            PDFGraphics.drawLine(start: CGPoint(x: frame.minX, y: y), end: CGPoint(x: frame.maxX, y: y), style: debugGridStyle)
//        }
//
//        for row in page.rows {
//            for cell in row.cells {
//                PDFGraphics.drawRect(rect: cell.cellFrame, outline: debugCellStyle)
//                PDFGraphics.drawRect(rect: cell.contentFrame, outline: debugCellContentStyle)
//            }
//        }
//    }

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
        } else {
            return style.contentStyle
        }
    }

}
