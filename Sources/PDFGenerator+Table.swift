//
//  PDFGenerator+Table.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func drawTable(_ container: PDFContainer, cells: [[PDFTableCell]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, style: PDFTableStyle, showHeadersOnEveryPage: Bool, newPageBreak: Bool = false, styleIndexOffset: Int = 0, calculatingMetrics: Bool) throws {
        
        try PDFTableValidator.validateCells(cells: cells, columnWidths: relativeColumnWidth)
        
        let totalWidth = layout.pageBounds.width - 2 * layout.margin.side - indentation[container.normalize]!
        var x: CGFloat = layout.margin.side + indentation[container.normalize]!
        var y: CGFloat = contentHeight
        
        // Calculate cells
        
        var cellFrames: [[CGRect]] = []
        var frames: [[CGRect]] = []
        
        for (rowIdx, row) in cells.enumerated() {
            frames.append([])
            cellFrames.append([])
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X position and size
            for (colIdx, cell) in row.enumerated() {
                let width = relativeColumnWidth[colIdx] * totalWidth
                let position = CGPoint(x: x + margin + padding, y: y + maxHeaderHeight() + layout.space.header + margin + padding)
                
                var frame = CGRect(origin: position, size: CGSize.zero)
                var cellFrame = CGRect(x: x + margin, y: y + maxHeaderHeight() + layout.space.header + margin, width: width - 2 * margin, height: 0)
                
                if let content = cell.content {
                    let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: cells.count, style: style, row: rowIdx, column: colIdx, cell: cell, newPageBreak: newPageBreak, showHeadersOnEveryPage: showHeadersOnEveryPage)
                    let attributes: [String: AnyObject] = [
                        NSForegroundColorAttributeName: cellStyle.colors.text,
                        NSFontAttributeName: cellStyle.font
                    ]
                    var result = CGRect.zero
                    
                    if (content.stringValue != nil) || (content.attributedStringValue != nil) {
                        let text: NSAttributedString = (content.attributedStringValue != nil) ? content.attributedStringValue! : NSAttributedString(string: content.stringValue!, attributes: attributes)
                        result = calculateCellFrame(position, width: width - 2 * margin - 2 * padding, text: text, alignment: cell.alignment)
                    } else if let image = content.imageValue {
                        result = calculateCellFrame(position, width: width - 2 * margin - 2 * padding, image: image)
                        let compressedImage = resizeAndCompressImage(image: image, frame: result)
                        content.content = compressedImage
                    }
                    maxHeight = max(maxHeight, result.height)
                    frame = result
                    
                    cellFrame = CGRect(x: x + margin, y: y + maxHeaderHeight() + layout.space.header + margin, width: width - 2 * margin, height: result.height)
                }
                
                frames[rowIdx].append(frame)
                cellFrames[rowIdx].append(cellFrame)
                
                x += width
            }
            
            // Reposition in Y-Axis
            for (colIdx, cell) in row.enumerated() {
                let alignment = cell.alignment
                let frame = frames[rowIdx][colIdx]
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
                frames[rowIdx][colIdx].origin.y = y
            }
            
            x = layout.margin.side
            y += maxHeight + 2 * margin + 2 * padding
        }
        
        // Divide tables according to contentSize
        var (cellsInThisPage, framesInThisPage): ([[PDFTableCell]], [[CGRect]]) = ([], [])
        var (cellsInNewPage): ([[PDFTableCell]]) = ([])
        var totalHeight: CGFloat = 0
        var nextPage = false
        
        for (rowIdx, row) in cells.enumerated() {
            let maxHeight = frames[rowIdx].reduce(0) { max($0, $1.height) }
            let cellHeight = maxHeight + 2 * padding
            let allHeight = cellHeight + 2 * margin
            
            if ((frames[rowIdx][0].origin.y + allHeight > contentSize.height + maxHeaderHeight() + layout.space.header) || nextPage) {
                nextPage = true
                cellsInNewPage.append(row)
            } else {
                cellsInThisPage.append(row)
                framesInThisPage.append(frames[rowIdx])
            }
            
            totalHeight += allHeight
            
            for (idx, frame) in cellFrames[rowIdx].enumerated() {
                var newFrame = frame
                newFrame.size.height = cellHeight
                cellFrames[rowIdx][idx] = newFrame
            }
        }
        
        let tableFrame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + layout.space.header, width: totalWidth, height: totalHeight)
        
        // Dont' render if calculating metrics
        if !calculatingMetrics {
            
            // Draw background
            
            for (rowIdx, row) in cellsInThisPage.enumerated() {
                for (colIdx, cell) in row.enumerated() {
                    let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: cells.count, style: style, row: rowIdx, column: colIdx, cell: cell, newPageBreak: newPageBreak, showHeadersOnEveryPage: showHeadersOnEveryPage)
                    let cellFrame = cellFrames[rowIdx][colIdx]
                    
                    let path = UIBezierPath(rect: cellFrame).cgPath
                    
                    let currentContext = UIGraphicsGetCurrentContext()!
                    
                    cellStyle.colors.fill.setFill()
                    currentContext.addPath(path)
                    currentContext.drawPath(using: .fill)
                }
            }
            
            // Draw content
            
            for (rowIdx, row) in cellsInThisPage.enumerated() {
                for (colIdx, cell) in row.enumerated() {
                    if let content = cell.content {
                        let frame = framesInThisPage[rowIdx][colIdx]
                        
                        if (content.stringValue != nil) || (content.attributedStringValue != nil) {
                            let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: cells.count, style: style, row: rowIdx, column: colIdx, cell: cell, newPageBreak: newPageBreak, showHeadersOnEveryPage: showHeadersOnEveryPage)
                            
                            let attributedText: NSAttributedString = {
                                // If
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
                            // the last line of text is hidden if 30 is not added
                            attributedText.draw(in: CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: frame.height + 20)))
                        } else if let image = content.imageValue {
                            image.draw(in: frame)
                        }
                    }
                }
            }
            
            // Draw grid lines
            
            for (rowIdx, row) in cellsInThisPage.enumerated() {
                for (colIdx, cell) in row.enumerated() {
                    let cellStyle = getCellStyle(offset: styleIndexOffset, tableHeight: cells.count, style: style, row: rowIdx, column: colIdx, cell: cell, newPageBreak: newPageBreak, showHeadersOnEveryPage: showHeadersOnEveryPage)
                    let cellFrame = cellFrames[rowIdx][colIdx]
                    
                    drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), style: cellStyle.borders.top)
                    drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borders.bottom)
                    drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), style: cellStyle.borders.left)
                    drawLine(start: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borders.right)
                }
            }
            
            // Draw table outline
            
            drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.minY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.minY), style: style.outline)
            drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.maxY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.maxY), style: style.outline)
            drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.minY), end: CGPoint(x: tableFrame.minX, y: tableFrame.maxY), style: style.outline)
            drawLine(start: CGPoint(x: tableFrame.maxX, y: tableFrame.minY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.maxY), style: style.outline)
        }
        
        // If headers are shown on every page add header rows at beginning
        if showHeadersOnEveryPage && cellsInNewPage.count > 0 {
            for i in 0..<style.rowHeaderCount {
                cellsInNewPage.insert(cells[i], at: i)
            }
        }
        
        // Continue with table on next page
        
        if !cellsInNewPage.isEmpty {
            try generateNewPage(calculatingMetrics: calculatingMetrics)
            try drawTable(container, cells: cellsInNewPage, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, style: style, showHeadersOnEveryPage: showHeadersOnEveryPage, newPageBreak: true, styleIndexOffset: cellsInThisPage.count, calculatingMetrics: calculatingMetrics)
        } else {
            contentHeight = tableFrame.maxY - maxHeaderHeight() - layout.space.header
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
