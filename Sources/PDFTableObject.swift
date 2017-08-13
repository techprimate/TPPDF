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
    
    struct PDFTablePage {
        
        var frame: CGRect
        var cells: [[PDFTableCellObject]]
    }
    
    struct PDFTableCellObject {
        
        weak var cell: PDFTableCell?
        var cellFrame: CGRect
        var contentFrame: CGRect
        
    }
    
    var cellsPerPage: [PDFTablePage] = []
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
        var y: CGFloat = generator.heights.content + generator.maxHeaderHeight()
        
        self.frame = CGRect(x: x, y: y, width: 0, height: 0)
        
        // Calculate cells
        
        let cells = table.cells
        var newPageBreak = false
        
        for (rowIdx, row) in cells.enumerated() {
            contentFrames.append([])
            cellFrames.append([])
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X, Y position and size
            for (colIdx, cell) in row.enumerated() {
                let columnWidth = table.widths[colIdx] * totalWidth
                let cellWidth = columnWidth - 2 * table.margin
                let contentWidth = columnWidth - 2 * (table.margin + table.padding)
                
                let contentPosition = CGPoint(
                    x: x + table.margin + table.padding,
                    y: y + document.layout.space.header + table.margin + table.padding
                )
                
                var contentFrame = CGRect(origin: contentPosition, size: CGSize.zero)
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
                        let attributes: [String: AnyObject] = [
                            NSForegroundColorAttributeName: cellStyle.colors.text,
                            NSFontAttributeName: cellStyle.font
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
                    maxHeight = max(maxHeight, result.height)
                    
                    contentFrame = result
                    cellFrame.size.height = maxHeight + table.margin
                }
                
                contentFrames[rowIdx].append(contentFrame)
                cellFrames[rowIdx].append(cellFrame)
                
                x += columnWidth
            }
            
            // Reposition in Y-Axis. This is for vertical alignment
            
            for (colIdx, cell) in row.enumerated() {
                let alignment = cell.alignment
                let frame = contentFrames[rowIdx][colIdx]
                let y: CGFloat = {
                    switch alignment.normalizeVertical {
                    case .center:
                        return frame.minY + (maxHeight - frame.height) / 2
                    case .bottom:
                        return frame.minY + maxHeight - frame.height
                    default:
                        return frame.minY
                    }
                }()
                contentFrames[rowIdx][colIdx].origin.y = y
            }
            
            for (colIdx, cell) in row.enumerated() {
                let alignment = cell.alignment
                let frame = cellFrames[rowIdx][colIdx]
                let y: CGFloat = {
                    switch alignment.normalizeVertical {
                    case .center:
                        return frame.minY + (maxHeight - frame.height) / 2
                    case .bottom:
                        return frame.minY + maxHeight - frame.height
                    default:
                        return frame.minY
                    }
                }()
                cellFrames[rowIdx][colIdx].origin.y = y
            }
            
            x = frame.minX
            y += maxHeight + 2 * table.margin + 2 * table.padding
        }
        
        var cellsOnThisPage: [[PDFTableCellObject]] = []
        var currentTablePage: PDFTablePage = PDFTablePage(frame: self.frame, cells: [])
        
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
            
            cellsOnThisPage.append(cellDataRow)
            currentTablePage.frame.size.height += maxHeight + 2 * (table.padding + table.margin)
            
            
            //
            //            if ((frames[rowIdx][0].origin.y + allHeight > generator.contentSize.height + generator.maxHeaderHeight() + document.layout.space.header) || nextPage) {
            //                nextPage = true
            //                cellsInNewPage.append(row)
            //            } else {
            //                cellsInThisPage.append(row)
            //                framesInThisPage.append(frames[rowIdx])
            //            }
            //
        }
        currentTablePage.cells = cellsOnThisPage
        cellsPerPage.append(currentTablePage)
        
        // If headers are shown on every page add header rows at beginning
        //        if table.showHeadersOnEveryPage && cellsInNewPage.count > 0 {
        //            for i in 0..<table.style.rowHeaderCount {
        //                cellsInNewPage.insert(cells[i], at: i)
        //            }
        //        }
        
        // Continue with table on next page
        
        //        if !cellsInNewPage.isEmpty {
        //            try generator.generateNewPage(calculatingMetrics: true)
        //        } else {
        generator.heights.content = self.frame.maxY - generator.maxHeaderHeight() - document.layout.space.header
        //        }
    }
    
    override func draw(generator: PDFGenerator, container: PDFContainer) throws {
        var newPageBreak = false
        let style = table.style
        
        // Draw background
        
        for page in cellsPerPage {
            for (rowIdx, row) in page.cells.enumerated() {
                for (colIdx, cell) in row.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }
                    let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: page.cells.count, style: table.style, row: rowIdx, column: colIdx, cell: pdfCell, newPageBreak: newPageBreak, showHeadersOnEveryPage: table.showHeadersOnEveryPage)
                    
                    let path = UIBezierPath(rect: cell.cellFrame).cgPath
                    
                    let currentContext = UIGraphicsGetCurrentContext()!
                    
                    cellStyle.colors.fill.setFill()
                    currentContext.addPath(path)
                    currentContext.drawPath(using: .fill)
                }
            }
            
            // Draw content
            
            for (rowIdx, row) in page.cells.enumerated() {
                for (colIdx, cell) in row.enumerated() {
                    guard let pdfCell = cell.cell else {
                        throw PDFError.tableCellWeakReferenceBroken
                    }
                    guard let content = pdfCell.content else { return }
                    
                    if (content.stringValue != nil) || (content.attributedStringValue != nil) {
                        let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: page.cells.count, style: style, row: rowIdx, column: colIdx, cell: pdfCell, newPageBreak: newPageBreak, showHeadersOnEveryPage: table.showHeadersOnEveryPage)
                        
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
            
            for (rowIdx, row) in page.cells.enumerated() {
                for (colIdx, cell) in row.enumerated() {
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
