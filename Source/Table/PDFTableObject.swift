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

    /**
     - throws: `PDFError` if table validation fails. See `PDFTableValidator.validateTableData(::)` for details
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        try PDFTableValidator.validateTable(table: table)

        /// All outer cell frame
        var cellFrames: [[CGRect]] = []
        /// All Inner content cell frame
        var contentFrames: [[CGRect]] = []
        
        cellsPerPage = []
        styleIndexOffset = 0

        let layout = generator.document.layout
        let availableSize = PDFCalculations.calculateAvailableFrame(for: generator, in: container)
        var origin = PDFCalculations.calculateElementPosition(for: generator, in: container, with: availableSize)

        self.frame = CGRect(x: origin.x, y: origin.y, width: availableSize.width, height: 0)
        
        // Calculate cells
        
        let cells = table.cells
        
        for (rowIdx, row) in cells.enumerated() {
            contentFrames.append([])
            cellFrames.append([])
            
            // Calcuate X, Y position and size
            for (colIdx, cell) in row.enumerated() {
                let columnWidth = table.widths[colIdx] * availableSize.width
                let cellWidth = columnWidth - 2 * table.margin
                let contentWidth = columnWidth - 2 * (table.margin + table.padding)
                
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
                    let cellStyle = getCellStyle(
                        offset: styleIndexOffset,
                        tableHeight: cells.count,
                        style: table.style,
                        row: rowIdx,
                        column: colIdx,
                        cell: cell,
                        showHeadersOnEveryPage: table.showHeadersOnEveryPage
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
            
            if allHeight + rowHeight - difference > layout.contentSize.height
                + generator.layout.heights.maxHeaderHeight()
                + layout.space.header {
                currentTablePage.rows = rowsOnThisPage
                cellsPerPage.append(currentTablePage)
                
                currentTablePage = PDFTablePageObject(frame: CGRect(origin: self.frame.origin,
                                                                    size: CGSize(width: self.frame.width, height: 0)),
                                                      rows: [])
                
                rowsOnThisPage = []
                allHeight = 0
            }
            
            difference = cellsPerPage.map { return $0.frame.height }.reduce(0, +)
            
            for idx in 0..<cellDataRow.count {
                cellDataRow[idx].cellFrame.origin.y -= difference
                cellDataRow[idx].contentFrame.origin.y -= difference
            }
            
            rowsOnThisPage.append(PDFTableRowObject(height: rowHeight, cells: cellDataRow))
            
            currentTablePage.frame.size.height += rowHeight
            allHeight += rowHeight
        }
        
        currentTablePage.rows = rowsOnThisPage
        cellsPerPage.append(currentTablePage)

        return [(container, self)]
    }

    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        for (pageIdx, page) in cellsPerPage.enumerated() {
            // Draw background
            try drawBackground(page: page)
            
            // Draw content
            try drawContent(page: page)
            
            // Draw grid lines
            try drawGridLines(page: page)
            
            // Draw table outline
            PDFGraphics.drawRect(rect: page.frame, outline: table.style.outline)
            
            // Debug drawing
            debugDraw(page: page)
            
            // Page break between tables
            if pageIdx != cellsPerPage.count - 1 {
//                try generator.generateNewPage(calculatingMetrics: false)
            }
        }
    }
    
    func updateHeights(generator: PDFGenerator, container: PDFContainer) {
        if let lastPage = cellsPerPage.last {
            generator.layout.heights.content = lastPage.frame.maxY
                - generator.layout.heights.maxHeaderHeight()
                - generator.document.layout.space.header
        }
    }
    
    func drawBackground(page: PDFTablePageObject) throws {
        try page.enumerateCells { (rowIndex, colIndex, row, cell, pdfCell) in
            let cellStyle = getCellStyle(offset: styleIndexOffset,
                                         tableHeight: page.rows.count,
                                         style: table.style,
                                         row: rowIndex,
                                         column: colIndex,
                                         cell: pdfCell,
                                         showHeadersOnEveryPage: table.showHeadersOnEveryPage)
            
            PDFGraphics.drawRect(rect: cell.cellFrame, outline: PDFLineStyle.none, fill: cellStyle.colors.fill)
        }
    }
    
    func drawContent(page: PDFTablePageObject) throws {
        try page.enumerateCells { (rowIndex, colIndex, row, cell, pdfCell) in
            guard let content = pdfCell.content else { return }
            
            if (content.stringValue != nil) || (content.attributedStringValue != nil) {
                let cellStyle = getCellStyle(offset: styleIndexOffset,
                                             tableHeight: page.rows.count,
                                             style: table.style,
                                             row: rowIndex,
                                             column: colIndex,
                                             cell: pdfCell,
                                             showHeadersOnEveryPage: table.showHeadersOnEveryPage)
                
                let attributedText: NSAttributedString = {
                    if let text = content.stringValue {
                        let attributes: [NSAttributedStringKey: AnyObject] = [
                            NSAttributedStringKey.foregroundColor: cellStyle.colors.text,
                            NSAttributedStringKey.font: cellStyle.font
                        ]
                        return NSAttributedString(string: text, attributes: attributes)
                    } else {
                        return content.attributedStringValue!
                    }
                }()
                // the last line of text is hidden if 20 is not added
                attributedText.draw(in: CGRect(origin: cell.contentFrame.origin,
                                               size: CGSize(width: cell.contentFrame.width,
                                                            height: cell.contentFrame.height + 20)))
            } else if let image = content.imageValue {
                let compressedImage = PDFGraphics.resizeAndCompressImage(image: image, frame: cell.contentFrame, quality: 0.85)
                compressedImage.draw(in: cell.contentFrame)
            }
        }
    }
    
    func drawGridLines(page: PDFTablePageObject) throws {
        try page.enumerateCells { (rowIndex, colIndex, row, cell, pdfCell) in
            let cellStyle = getCellStyle(
                offset: styleIndexOffset,
                tableHeight: table.cells.count,
                style: table.style,
                row: rowIndex,
                column: colIndex,
                cell: pdfCell,
                showHeadersOnEveryPage: table.showHeadersOnEveryPage
            )
            let cellFrame = cell.cellFrame
            
            PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                                 end: CGPoint(x: cellFrame.maxX, y: cellFrame.minY),
                                 style: cellStyle.borders.top)
            PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.maxY),
                                 end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY),
                                 style: cellStyle.borders.bottom)
            PDFGraphics.drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
                                 end: CGPoint(x: cellFrame.minX, y: cellFrame.maxY),
                                 style: cellStyle.borders.left)
            PDFGraphics.drawLine(start: CGPoint(x: cellFrame.maxX, y: cellFrame.minY),
                                 end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY),
                                 style: cellStyle.borders.right)
        }
    }
    
    func debugDraw(page: PDFTablePageObject) {
        guard PDFGenerator.debug else { return }
        
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
    
    func getCellStyle(offset: Int,
                      tableHeight: Int,
                      style: PDFTableStyle,
                      row: Int,
                      column: Int,
                      cell: PDFTableCell,
                      showHeadersOnEveryPage: Bool) -> PDFTableCellStyle {
        let position = PDFTableCellPosition(row: (row + offset), column: column)
        
        if let cellStyle = cell.style {
            return cellStyle
        }
        if position.row < style.columnHeaderCount || (position.row - offset < style.columnHeaderCount) {
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


    struct PDFTablePageObject {

        var frame: CGRect
        var rows: [PDFTableRowObject]

        func enumerateCells(_ closure: (Int, Int, PDFTableRowObject, PDFTableCellObject, PDFTableCell) -> Void) throws {
            for (rowIdx, row) in rows.enumerated() {
                for (colIdx, cell) in row.cells.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }
                    closure(rowIdx, colIdx, row, cell, pdfCell)
                }
            }
        }
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

}
