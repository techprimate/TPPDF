//
//  PDFGenerator+Table.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func drawTable(_ container: Container, data: [[String]], alignments: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, style: TableStyle, newPageBreak: Bool = false, styleIndexOffset: Int = 0) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignments.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerated() {
            assert(row.count == alignments[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        
        let totalWidth = pageBounds.width - 2 * pageMargin - indentation[container.normalize]!
        var x: CGFloat = pageMargin + indentation[container.normalize]!
        var y: CGFloat = contentHeight
        
        // Calculate cells
        
        var cellFrames: [[CGRect]] = []
        var frames: [[CGRect]] = []
        
        for (rowIdx, row) in data.enumerated() {
            frames.append([])
            cellFrames.append([])
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X position and size
            for (colIdx, column) in row.enumerated() {
                let cellStyle = getCellStyle(tableHeight: data.count + styleIndexOffset, style: style, row: styleIndexOffset + rowIdx, column: colIdx, newPageBreak: newPageBreak)
                let attributes: [String: AnyObject] = [
                    NSForegroundColorAttributeName: cellStyle.textColor,
                    NSFontAttributeName: cellStyle.font
                ]
                
                let text = NSAttributedString(string: column, attributes: attributes)
                let width = relativeColumnWidth[colIdx] * totalWidth
                let result = calculateCellFrame(CGPoint(x: x + margin + padding, y: y + maxHeaderHeight() + headerSpace + margin + padding), width: width - 2 * margin - 2 * padding, text: text, alignment: alignments[rowIdx][colIdx])
                
                maxHeight = max(maxHeight, result.height)
                frames[rowIdx].append(result)
                
                let cellFrame = CGRect(x: x + margin, y: y + maxHeaderHeight() + headerSpace + margin, width: width - 2 * margin, height: result.height);
                cellFrames[rowIdx].append(cellFrame)
                
                x += width
            }
            
            // Reposition in Y-Axis
            for (colIdx, _) in row.enumerated() {
                let alignment = alignments[rowIdx][colIdx]
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
            
            x = pageMargin
            y += maxHeight + 2 * margin + 2 * padding
        }
        
        // Divide tables according to contentSize
        var (dataInThisPage, alignmentsInThisPage, framesInThisPage): ([[String]], [[TableCellAlignment]], [[CGRect]]) = ([], [], [])
        var (dataInNewPage, alignmentsInNewPage): ([[String]], [[TableCellAlignment]]) = ([], [])
        var totalHeight: CGFloat = 0
        
        for (rowIdx, row) in data.enumerated() {
            let maxHeight = frames[rowIdx].reduce(0) { max($0, $1.height) }
            let cellHeight = maxHeight + 2 * padding
            
            if (frames[rowIdx][0].origin.y + cellHeight > contentSize.height + maxHeaderHeight() + headerSpace) {
                dataInNewPage.append(row)
                alignmentsInNewPage.append(alignments[rowIdx])
            } else {
                dataInThisPage.append(row)
                alignmentsInThisPage.append(alignments[rowIdx])
                framesInThisPage.append(frames[rowIdx])
                
                totalHeight += cellHeight + 2 * margin
            }
            for (idx, frame) in cellFrames[rowIdx].enumerated() {
                var newFrame = frame
                newFrame.size.height = cellHeight
                cellFrames[rowIdx][idx] = newFrame
            }
        }
        
        // Draw background
        
        for (rowIdx, row) in dataInThisPage.enumerated() {
            for (colIdx, _) in row.enumerated() {
                let cellStyle = getCellStyle(tableHeight: data.count + styleIndexOffset, style: style, row: styleIndexOffset + rowIdx, column: colIdx, newPageBreak: newPageBreak)
                let cellFrame = cellFrames[rowIdx][colIdx]
                
                let path = UIBezierPath(rect: cellFrame).cgPath
                
                let currentContext = UIGraphicsGetCurrentContext()!
                
                cellStyle.fillColor.setFill()
                currentContext.addPath(path)
                currentContext.drawPath(using: .fill)
            }
        }
        
        // Draw text
        
        for (rowIdx, row) in dataInThisPage.enumerated() {
            for (colIdx, text) in row.enumerated() {
                let cellStyle = getCellStyle(tableHeight: data.count + styleIndexOffset, style: style, row: styleIndexOffset + rowIdx, column: colIdx, newPageBreak: newPageBreak)
                
                let attributes: [String: AnyObject] = [
                    NSForegroundColorAttributeName: cellStyle.textColor,
                    NSFontAttributeName: cellStyle.font
                ]
                
                let textFrame = framesInThisPage[rowIdx][colIdx]
                let attributedText = NSAttributedString(string: text, attributes: attributes)
                // the last line of text is hidden if 30 is not added
                attributedText.draw(in: CGRect(origin: textFrame.origin, size: CGSize(width: textFrame.width, height: textFrame.height + 20)))
            }
        }
        
        // Draw grid lines
        
        for (rowIdx, row) in dataInThisPage.enumerated() {
            for (colIdx, _) in row.enumerated() {
                let cellStyle = getCellStyle(tableHeight: data.count + styleIndexOffset, style: style, row: styleIndexOffset + rowIdx, column: colIdx, newPageBreak: newPageBreak)
                let cellFrame = cellFrames[rowIdx][colIdx]
                
                drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), style: cellStyle.borderTop)
                drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borderBottom)
                drawLine(start: CGPoint(x: cellFrame.minX, y: cellFrame.minY), end: CGPoint(x: cellFrame.minX, y: cellFrame.maxY), style: cellStyle.borderLeft)
                drawLine(start: CGPoint(x: cellFrame.maxX, y: cellFrame.minY), end: CGPoint(x: cellFrame.maxX, y: cellFrame.maxY), style: cellStyle.borderRight)
            }
        }
        
        // Draw table outline
        
        let tableFrame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + headerSpace, width: totalWidth, height: totalHeight)
        drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.minY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.minY), style: style.outline)
        drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.maxY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.maxY), style: style.outline)
        drawLine(start: CGPoint(x: tableFrame.minX, y: tableFrame.minY), end: CGPoint(x: tableFrame.minX, y: tableFrame.maxY), style: style.outline)
        drawLine(start: CGPoint(x: tableFrame.maxX, y: tableFrame.minY), end: CGPoint(x: tableFrame.maxX, y: tableFrame.maxY), style: style.outline)
        
        // Continue with table on next page
        
        if !dataInNewPage.isEmpty {
            generateNewPage()
            drawTable(container, data: dataInNewPage, alignments: alignmentsInNewPage, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, style: style, newPageBreak: true, styleIndexOffset: dataInThisPage.count)
        } else {
            contentHeight = tableFrame.maxY - maxHeaderHeight() - headerSpace
        }
    }
    
    func getCellStyle(tableHeight: Int, style: TableStyle, row: Int, column: Int, newPageBreak: Bool) -> TableCellStyle {
        let position = TableCellPosition(row: row, column: column)
        
        if let cellStyle = style.cellStyles[position] {
            return cellStyle
        }
        if row < style.columnHeaderCount && !newPageBreak{
            return style.columnHeaderStyle
        }
        if row >= tableHeight - style.footerCount {
            return style.footerStyle
        }
        if column < style.rowHeaderCount {
            return style.rowHeaderStyle
        }
        if (row - style.rowHeaderCount) % 2 == 1 {
            return style.alternatingContentStyle ?? style.contentStyle
        } else {
            return style.contentStyle
        }
    }
}
