//
//  PDFTableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

class PDFTableObject : PDFObject {
    
    var table: PDFTable
    
    init(table: PDFTable) {
        self.table = table
    }
    
    struct PDFTablePageObject {
        
        var frame: CGRect
        var rows: [PDFTableRowObject]
        
    }
    
    struct PDFTableRowObject {
        
        var height: CGFloat
        var cells: [PDFTableCellObject]
        
    }
    
    struct PDFTableCellObject {
        
        weak var cell: PDFTableCell?
        var cellFrame: CGRect
        var contentFrame: CGRect
        
    }
    
    var cellsPerPage: [PDFTablePageObject] = []
    var styleIndexOffset: Int = 0
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
        
        /// All outer cell frame
        var cellFrames: [[CGRect]] = []
        /// All Inner content cell frame
        var contentFrames: [[CGRect]] = []
        
        cellsPerPage = []
        styleIndexOffset = 0
        
        try PDFTableValidator.validateTable(table: table)
        
        let document = generator.document
        
        let totalWidth = document.layout.size.width - 2 * document.layout.margin.side - generator.indentation[container.normalize]!
        
        var x: CGFloat = document.layout.margin.side + generator.indentation[container.normalize]!
        var y: CGFloat = generator.maxHeaderHeight() + document.layout.margin.header + generator.heights.content
        
        self.frame = CGRect(x: x, y: y, width: totalWidth, height: 0)
        
        // Calculate cells
        
        let cells = table.cells
        var newPageBreak = false
        
        for (rowIdx, row) in cells.enumerated() {
            contentFrames.append([])
            cellFrames.append([])
            
            // Calcuate X, Y position and size
            for (colIdx, cell) in row.enumerated() {
                let columnWidth = table.widths[colIdx] * totalWidth
                let cellWidth = columnWidth - 2 * table.margin
                let contentWidth = columnWidth - 2 * (table.margin + table.padding)
                
                let contentPosition = CGPoint(
                    x: x + table.margin + table.padding,
                    y: y + document.layout.space.header + table.margin + table.padding
                )
                
                var contentFrame = CGRect(
                    origin: contentPosition,
                    size: CGSize(width: contentWidth, height: 0)
                )
                var cellFrame = CGRect(
                    x: x + table.margin,
                    y: y + table.margin,
                    width: cellWidth,
                    height: 0
                )
                
                if let content = cell.content {
                    let cellStyle = getCellStyle(
                        offset: styleIndexOffset,
                        tableHeight: cells.count,
                        style: table.style,
                        row: rowIdx,
                        column: colIdx,
                        cell: cell,
                        newPageBreak: newPageBreak,
                        showHeadersOnEveryPage: table.showHeadersOnEveryPage
                    )
                    var result = CGRect.zero
                    
                    switch content.content {
                    case let text as String:
                        let paragraph = NSMutableParagraphStyle()
                        paragraph.alignment = {
                            switch cell.alignment.normalizeHorizontal {
                            case .right:
                                return NSTextAlignment.right
                            case .center:
                                return NSTextAlignment.center
                            default:
                                return NSTextAlignment.left
                            }
                        }()
                        
                        let attributes: [String: AnyObject] = [
                            NSForegroundColorAttributeName: cellStyle.colors.text,
                            NSFontAttributeName: cellStyle.font,
                            NSParagraphStyleAttributeName: paragraph
                        ]
                        let attributedText = NSAttributedString(string: text, attributes: attributes)
                        result = generator.calculateCellFrame(contentPosition, width: contentWidth, text: attributedText, alignment: cell.alignment)
                        break
                    case let text as NSAttributedString:
                        result = generator.calculateCellFrame(contentPosition, width: contentWidth, text: text, alignment: cell.alignment)
                        break
                    case let image as UIImage:
                        result = generator.calculateCellFrame(contentPosition, width: contentWidth, image: image)
                        break
                    default:
                        break
                    }
                    
                    contentFrame.size = result.size
                    cellFrame.size.height = result.height + 2 * table.padding
                }
                
                contentFrames[rowIdx].append(contentFrame)
                cellFrames[rowIdx].append(cellFrame)
                
                x += columnWidth
            }
            
            // Reposition in Y-Axis. This is for vertical alignment
            
            var maxCellHeight: CGFloat = cellFrames[rowIdx].map { return $0.height }.max() ?? 0
            
            for (colIdx, cell) in row.enumerated() {
                let alignment = cell.alignment
                let cellFrame = cellFrames[rowIdx][colIdx]
                let contentFrame = contentFrames[rowIdx][colIdx]
                
                let contentX: CGFloat = {
                    switch alignment.normalizeHorizontal {
                    case .center:
                        return contentFrame.minX + (cellFrame.width - 2 * table.padding - contentFrame.width) / 2
                    case .right:
                        return contentFrame.maxX - table.padding - contentFrame.width
                    default:
                        return contentFrame.minX
                    }
                }()
                
                let contentY: CGFloat = {
                    switch alignment.normalizeVertical {
                    case .center:
                        return contentFrame.minY + (maxCellHeight - 2 * table.padding - contentFrame.height) / 2
                    case .bottom:
                        return contentFrame.minY + maxCellHeight - 2 * table.padding - contentFrame.height
                    default:
                        return contentFrame.minY
                    }
                }()
                
                contentFrames[rowIdx][colIdx].origin.x = contentX
                contentFrames[rowIdx][colIdx].origin.y = contentY
                cellFrames[rowIdx][colIdx].size.height = maxCellHeight
            }
            
            x = frame.minX
            y += maxCellHeight + 2 * (table.margin)
        }
        
        var allHeight: CGFloat = 0
        
        var rowsOnThisPage: [PDFTableRowObject] = []
        var currentTablePage: PDFTablePageObject = PDFTablePageObject(frame: self.frame, rows: [])
        
        currentTablePage.frame.size.height = 0
        
        for (rowIdx, row) in cells.enumerated() {
            var maxHeight: CGFloat = 0
            
            var cellDataRow: [PDFTableCellObject] = []
            
            for (colIdx, cell) in row.enumerated() {
                let cellFrame = cellFrames[rowIdx][colIdx]
                let contentFrame = contentFrames[rowIdx][colIdx]
                
                maxHeight = max(maxHeight, cellFrame.height)
                
                cellDataRow.append(PDFTableCellObject(cell: cell, cellFrame: cellFrame, contentFrame: contentFrame))
            }
            
            let rowHeight = maxHeight + 2 * table.margin
            
            var difference = cellsPerPage.map { return $0.frame.height }.reduce(0, +)
            
            if allHeight + rowHeight - difference > generator.contentSize.height + generator.maxHeaderHeight() + document.layout.space.header {
                currentTablePage.rows = rowsOnThisPage
                cellsPerPage.append(currentTablePage)
                
                currentTablePage = PDFTablePageObject(frame: CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width, height: 0)), rows: [])
                
                rowsOnThisPage = []
                allHeight = 0
            }
            
            difference = cellsPerPage.map { return $0.frame.height }.reduce(0, +)
            
            for (idx, cell) in cellDataRow.enumerated() {
                cellDataRow[idx].cellFrame.origin.y -= difference
                cellDataRow[idx].contentFrame.origin.y -= difference
            }
            
            rowsOnThisPage.append(PDFTableRowObject(height: rowHeight, cells: cellDataRow))
            
            currentTablePage.frame.size.height += rowHeight
            allHeight += rowHeight
        }
        
        currentTablePage.rows = rowsOnThisPage
        cellsPerPage.append(currentTablePage)
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        var newPageBreak = false
        let style = table.style
        
        // Draw background
        
        for (pageIdx, page) in cellsPerPage.enumerated() {
            for (rowIdx, row) in page.rows.enumerated() {
                for (colIdx, cell) in row.cells.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }
                    let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: page.rows.count, style: table.style, row: rowIdx, column: colIdx, cell: pdfCell, newPageBreak: newPageBreak, showHeadersOnEveryPage: table.showHeadersOnEveryPage)
                    
                    PDFGraphics.drawRect(rect: cell.cellFrame, outline: PDFLineStyle.none, fill: cellStyle.colors.fill)
                }
            }
            
            // Draw content
            
            for (rowIdx, row) in page.rows.enumerated() {
                for (colIdx, cell) in row.cells.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }
                    guard let content = pdfCell.content else { return }
                    
                    if (content.stringValue != nil) || (content.attributedStringValue != nil) {
                        let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: page.rows.count, style: style, row: rowIdx, column: colIdx, cell: pdfCell, newPageBreak: newPageBreak, showHeadersOnEveryPage: table.showHeadersOnEveryPage)
                        
                        let attributedText: NSAttributedString = {
                            if let text = content.stringValue {
                                let attributes: [String: AnyObject] = [
                                    NSForegroundColorAttributeName: cellStyle.colors.text,
                                    NSFontAttributeName: cellStyle.font
                                ]
                                return NSAttributedString(string: text, attributes: attributes)
                            } else {
                                return content.attributedStringValue!
                            }
                        }()
                        // the last line of text is hidden if 20 is not added
                        attributedText.draw(in: CGRect(origin: cell.contentFrame.origin, size: CGSize(width: cell.contentFrame.width, height: cell.contentFrame.height + 20)))
                    } else if let image = content.imageValue {
                        let compressedImage = PDFGraphics.resizeAndCompressImage(image: image, frame: cell.contentFrame, quality: generator.imageQuality) ?? image
                        compressedImage.draw(in: cell.contentFrame)
                    }
                }
            }
            
            // Draw grid lines
            
            for (rowIdx, row) in page.rows.enumerated() {
                for (colIdx, cell) in row.cells.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }

                    let cellStyle = getCellStyle(
                        offset: styleIndexOffset,
                        tableHeight: table.cells.count,
                        style: table.style,
                        row: rowIdx,
                        column: colIdx,
                        cell: pdfCell,
                        newPageBreak: newPageBreak,
                        showHeadersOnEveryPage: table.showHeadersOnEveryPage
                    )
                    let cellFrame = cell.cellFrame
                    
                    PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), style: cellStyle.borders.top)
                    PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borders.bottom)
                    PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), style: cellStyle.borders.left)
                    PDFGraphics.drawLine(start: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borders.right)
                }
            }
            
            // Draw table outline
            
            let frame = page.frame
            
            PDFGraphics.drawLine(start: CGPoint(x: frame.minX, y: frame.minY), end: CGPoint(x: frame.maxX, y: frame.minY), style: style.outline)
            PDFGraphics.drawLine(start: CGPoint(x: frame.minX, y: frame.maxY), end: CGPoint(x: frame.maxX, y: frame.maxY), style: style.outline)
            PDFGraphics.drawLine(start: CGPoint(x: frame.minX, y: frame.minY), end: CGPoint(x: frame.minX, y: frame.maxY), style: style.outline)
            PDFGraphics.drawLine(start: CGPoint(x: frame.maxX, y: frame.minY), end: CGPoint(x: frame.maxX, y: frame.maxY), style: style.outline)
            
            if PDFGenerator.debug {
                let debugGridStyle = PDFLineStyle(type: .full, color: UIColor.red, width: 1.0)
                let debugCellStyle = PDFLineStyle(type: .full, color: UIColor.green, width: 1.0)
                let debugCellContentStyle = PDFLineStyle(type: .full, color: UIColor.blue, width: 1.0)
                
                var x: CGFloat = frame.minX
                for width in [0] + table.widths {
                    x += width * frame.width
                    PDFGraphics.drawLine(start: CGPoint(x: x, y: frame.minY), end: CGPoint(x: x, y: frame.maxY), style: debugGridStyle)
                }
                
                var y: CGFloat = frame.minY
                for height in [0] + page.rows.map { return $0.height } {
                    y += height
                    PDFGraphics.drawLine(start: CGPoint(x: frame.minX, y: y), end: CGPoint(x: frame.maxX, y: y), style: debugGridStyle)
                }
                
                for row in page.rows {
                    for cell in row.cells {
                        PDFGraphics.drawRect(rect: cell.cellFrame, outline: debugCellStyle)
                        PDFGraphics.drawRect(rect: cell.contentFrame, outline: debugCellContentStyle)
                    }
                }
            }
            
            if pageIdx != cellsPerPage.count - 1 {
                try generator.generateNewPage(calculatingMetrics: false)
            }
        }
    }
    
    func getCellStyle(offset: Int, tableHeight: Int, style: PDFTableStyle, row: Int, column: Int, cell: PDFTableCell, newPageBreak: Bool, showHeadersOnEveryPage: Bool) -> PDFTableCellStyle {
        let position = PDFTableCellPosition(row: (row + offset), column: column)
        
        if let cellStyle = cell.style {
            return cellStyle
        }
        if position.row < style.columnHeaderCount && !newPageBreak || (position.row - offset < style.columnHeaderCount){
            return style.columnHeaderStyle
        }
        if position.row > tableHeight + offset - style.footerCount {
            return style.footerStyle
        }
        if column < style.rowHeaderCount {
            return style.rowHeaderStyle
        }
        if (position.row - style.rowHeaderCount) % 2 == 1 {
            return style.alternatingContentStyle ?? style.contentStyle
        } else {
            return style.contentStyle
        }
    }
}
