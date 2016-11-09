//
//  PDFGenerator.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 11/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit

public class PDFGenerator  {
    
    // MARK: - Public Variables
    
    public var pageBounds: CGRect = CGRectZero
    public var pageMargin: CGFloat = 0
    
    public var headerMargin: CGFloat = 0
    public var footerMargin: CGFloat = 0
    
    public var headerSpace: CGFloat = 0
    public var footerSpace: CGFloat = 0
    
    // MARK: - Private Variables
    
    private var commands: [(Container, Command)] = []
    
    private var headerHeight: [Container : CGFloat] = [:]
    private var footerHeight: [Container : CGFloat] = [:]
    private var contentHeight: CGFloat = 0
    
    private var contentSize: CGSize {
        return CGSize(width: pageBounds.width - 2 * pageMargin, height: pageBounds.height - maxHeaderHeight() - headerSpace - maxFooterHeight() - footerSpace)
    }
    
    private var headerFooterCommands: [(Container, Command)] = []
    private let font = UIFont.systemFontOfSize(UIFont.systemFontSize())
    
    private var indentation: [Container: CGFloat] = [
        .HeaderLeft : 0,
        .ContentLeft : 0,
        .FooterLeft : 0
    ]
    
    // MARK: - Initializing
    
    public init(pageSize: CGSize, pageMargin: CGFloat = 36.0, headerMargin: CGFloat = 20.0, footerMargin: CGFloat = 20.0, headerSpace: CGFloat = 8, footerSpace: CGFloat = 8) {
        pageBounds = CGRect(origin: CGPoint.zero, size: pageSize)
        self.pageMargin = pageMargin
        
        self.footerMargin = footerMargin
        self.headerMargin = headerMargin
        
        self.headerSpace = headerSpace
        self.footerSpace = footerSpace
        
        resetHeaderFooterHeight()
    }
    
    public init(format: PageFormat) {
        pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        pageMargin = format.margin
        
        footerMargin = format.footerMargin
        headerMargin = format.headerMargin
        
        headerSpace = format.headerSpace
        footerSpace = format.footerSpace
        
        resetHeaderFooterHeight()
    }
    
    // MARK: - Preparation
    
    public func addText(container: Container = Container.ContentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        commands += [(container, .AddText(text: text, lineSpacing: lineSpacing)) ]
    }
    
    public func addAttributedText(container: Container = Container.ContentLeft, text: NSAttributedString) {
        commands += [(container, .AddAttributedText(text: text)) ]
    }
    
    public func addImage(container: Container = Container.ContentLeft, image: UIImage, size: CGSize = CGSizeZero) {
        commands += [(container, .AddImage(image: image, size: size))]
    }
    
    public func addSpace(container: Container = Container.ContentLeft, space: CGFloat) {
        commands += [(container, .AddSpace(space: space))]
    }
    
    public func addLineSeparator(container: Container = Container.ContentLeft, thickness: CGFloat = 1.0, color: UIColor = UIColor.blackColor()) {
        commands += [(container, .AddLineSeparator(thickness: thickness, color: color))]
    }
    
    public func addTable(container: Container = Container.ContentLeft, data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat = 0, margin: CGFloat = 0, textColor: UIColor = UIColor.blackColor(), lineColor: UIColor = UIColor.darkGrayColor(), lineWidth: CGFloat = 1.0, drawCellBounds: Bool = false) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignment.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerate() {
            assert(row.count == alignment[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        
        commands += [(container, .AddTable(data: data, alignment: alignment, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds))]
    }
    
    public func setIndentation(container: Container = Container.ContentLeft, indent: CGFloat) {
        commands += [(container, .SetIndentation(points: indent))]
    }
    
    public func setAbsoluteOffset(container: Container = Container.ContentLeft, offset: CGFloat) {
        commands += [(container, .SetOffset(points: offset))]
    }
    
    // MARK: - Generation
    
    public func generatePDFdata(progress: ((CGFloat) -> ())? = nil) -> NSData {
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, pageBounds, nil)
        UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
        
        headerFooterCommands = commands.filter { return $0.0.isFooter || $0.0.isHeader }
        let contentCommands = commands.filter { return !$0.0.isFooter && !$0.0.isHeader }
        
        let footers = commands.filter { return $0.0.isFooter }
        let headers = commands.filter { return $0.0.isHeader }
        
        if footers.count == 0 {
            footerSpace = 0
        }
        
        if headers.count == 0 {
            headerSpace = 0
        }
        
        if contentCommands.count > 0 {
            renderHeaderFooter()
        }
        
        
        let count: CGFloat = CGFloat(contentCommands.count)
        
        for (idx, (container, command)) in contentCommands.enumerate() {
            renderCommand(container, command: command)
            progress?(CGFloat(idx + 1) / count)
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    // MARK: - Rendering
    
    private func drawText(container: Container, text: String, font: UIFont, spacing: CGFloat, repeated: Bool = false) {
        let paragraphStyle = NSMutableParagraphStyle()
        switch container {
        case .HeaderLeft, .ContentLeft, .FooterLeft:
            paragraphStyle.alignment = .Left
        case .HeaderCenter, .ContentCenter, .FooterCenter:
            paragraphStyle.alignment = .Center
        case .HeaderRight, .ContentRight, .FooterRight:
            paragraphStyle.alignment = .Right
        default:
            paragraphStyle.alignment = .Left
        }
        
        paragraphStyle.lineSpacing = spacing
        
        let attributes: [String:NSObject] = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
        
        drawAttributedText(container, text: NSAttributedString(string: text, attributes: attributes))
    }
    
    private func drawAttributedText(container: Container, text: NSAttributedString, repeated: Bool = false) {
        let currentText = CFAttributedStringCreateCopy(nil, text as CFAttributedStringRef)
        let framesetter = CTFramesetterCreateWithAttributedString(currentText)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        
        repeat {
            // Get the graphics context.
            let currentContext = UIGraphicsGetCurrentContext()!
            
            // Push state
            CGContextSaveGState(currentContext)
            
            // Put the text matrix into a known state. This ensures
            // that no old scaling factors are left in place.
            CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity)
            
            let textMaxWidth = pageBounds.width - 2 * pageMargin - indentation[container.normalize]!
            let textMaxHeight: CGFloat = {
                if container.isHeader {
                    return pageBounds.height - headerHeight[container]!
                } else if container.isFooter {
                    return footerMargin
                } else {
                    return pageBounds.height - maxHeaderHeight() - headerSpace - maxFooterHeight() - footerSpace - contentHeight
                }
            }()
            
            // Create a path object to enclose the text.
            let frame: CGRect = {
                if container.isHeader {
                    return CGRect(x: pageMargin + indentation[container.normalize]!, y: 0, width: textMaxWidth, height: textMaxHeight)
                } else if container.isFooter {
                    return CGRect(x: pageMargin + indentation[container.normalize]!, y: footerHeight[container]!, width: textMaxWidth, height: textMaxHeight)
                } else {
                    return CGRect(x: pageMargin + indentation[container.normalize]!, y: maxFooterHeight() + footerSpace, width: textMaxWidth, height: textMaxHeight)
                }
            }()
            let framePath = UIBezierPath(rect: frame).CGPath
            
            // Get the frame that will do the rendering.
            // The currentRange variable specifies only the starting point. The framesetter
            // lays out as much text as will fit into the frame.
            let frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
            
            // Core Text draws from the bottom-left corner up, so flip
            // the current transform prior to drawing.
            CGContextTranslateCTM(currentContext, 0, pageBounds.height)
            CGContextScaleCTM(currentContext, 1.0, -1.0)
            
            // Draw the frame.
            CTFrameDraw(frameRef, currentContext)
            
            // Pop state
            CGContextRestoreGState(currentContext)
            
            // Update the current range based on what was drawn.
            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
            currentRange = CFRange(location: visibleRange.location + visibleRange.length , length: 0)
            
            // Update last drawn frame
            let constraintSize = CGSize(width: textMaxWidth, height: textMaxHeight)
            let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, constraintSize, nil)
            
            if container.isHeader {
                headerHeight[container] = headerHeight[container]! + drawnSize.height
            } else if container.isFooter {
                footerHeight[container] = footerHeight[container]! + drawnSize.height
            } else {
                contentHeight += drawnSize.height
            }
            if currentRange.location == CFAttributedStringGetLength(currentText){
                done = true
            } else {
                UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
                contentHeight = 0
                
                renderHeaderFooter()
            }
        } while(!done)
    }
    
    private func drawImage(container: Container, image: UIImage, size: CGSize) {
        var maxWidth: CGFloat = 0
        var maxHeight: CGFloat = 0
        
        /* calculate the aspect size of image */
        if size == CGSizeZero {
            maxWidth = min(image.size.width, contentSize.width - indentation[container.normalize]!)
            maxHeight = min(image.size.height, contentSize.height)
        } else {
            maxWidth = min(size.width, contentSize.width - indentation[container.normalize]!)
            maxHeight = min(size.width, contentSize.height - contentHeight)
        }
        let wFactor = image.size.width / maxWidth
        let hFactor = image.size.height / maxHeight
        
        let factor = max(wFactor, hFactor)
        
        let aspectWidth = image.size.width / factor
        let aspectHeight = image.size.height / factor
        
        let x: CGFloat = {
            switch container {
            case .ContentLeft:
                return pageMargin + indentation[container.normalize]!
            case .ContentCenter:
                return pageBounds.midX - aspectWidth / 2
            case .ContentRight:
                return pageBounds.width - pageMargin - aspectWidth
            default:
                return 0
            }
        }()
        
        let frame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + headerSpace, width: aspectWidth, height: aspectHeight)
        
        image.drawInRect(frame)
        
        contentHeight += frame.height
    }
    
    private func drawLineSeparator(container: Container, thickness: CGFloat, color: UIColor) {
        let drawRect = CGRect(x: pageMargin + indentation[container.normalize]!, y: contentHeight + maxHeaderHeight() + headerSpace, width: contentSize.width -  indentation[container.normalize]!, height: thickness)
        let path = UIBezierPath(rect: drawRect).CGPath
        
        // Get the graphics context.
        let currentContext = UIGraphicsGetCurrentContext()!
        
        // Set color
        color.setStroke()
        color.setFill()
        
        // Draw path
        CGContextAddPath(currentContext, path)
        CGContextDrawPath(currentContext, .FillStroke)
    }
    
    private func drawTable(container: Container, data: [[String]], alignments: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, textColor: UIColor, lineColor: UIColor, lineWidth: CGFloat, drawCellBounds: Bool) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignments.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerate() {
            assert(row.count == alignments[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        
        let totalWidth = pageBounds.width - 2 * pageMargin - indentation[container.normalize]!
        var x: CGFloat = pageMargin + indentation[container.normalize]!
        var y: CGFloat = contentHeight
        
        // Calculate cells
        
        var frames: [[CGRect]] = []
        
        let attributes: [String: AnyObject] = [
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: font
        ]
        
        for (rowIdx, row) in data.enumerate() {
            frames.append([])
            
            x += margin + padding
            y += margin + padding
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X position and size
            for (colIdx, column) in row.enumerate() {
                let width = relativeColumnWidth[colIdx] * totalWidth
                let result = calculateCellFrame(CGPoint(x: x, y: y + maxHeaderHeight() + headerSpace), width: width - 2 * margin - 2 * padding, text: column, alignment: alignments[rowIdx][colIdx], attributes: attributes)
                x += width
                maxHeight = max(maxHeight, result.height)
                frames[rowIdx].append(result)
            }
            
            // Reposition in Y-Axis
            for (colIdx, _) in row.enumerate() {
                let alignment = alignments[rowIdx][colIdx]
                let frame = frames[rowIdx][colIdx]
                let y: CGFloat = {
                    switch alignment.normalizeVertical {
                    case .Center:
                        return frame.minY + (maxHeight - frame.height) / 2
                    case .Bottom:
                        return frame.minY + maxHeight - frame.height
                    default:
                        return frame.minY
                    }
                }()
                frames[rowIdx][colIdx].origin.y = y
            }
            
            x = pageMargin
            y += maxHeight + margin + padding
        }
        
        // Draw text
        
        for (rowIdx, row) in data.enumerate() {
            for (colIdx, text) in row.enumerate() {
                let frame = frames[rowIdx][colIdx]
                text.drawAtPoint(frame.origin, withAttributes: attributes)
            }
        }
        
        // Begin drawing grid
        
        let context = UIGraphicsGetCurrentContext()!
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 0.0)
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor)
        CGContextSetLineWidth(context, lineWidth)
        
        // Draw cell bounding box
        
        if drawCellBounds {
            for (rowIdx, row) in data.enumerate() {
                for (colIdx, _) in row.enumerate() {
                    let frame = frames[rowIdx][colIdx]
                    let borderFrame = CGRect(x: frame.minX - padding, y: frame.minY - padding, width: frame.width + 2 * padding, height: frame.height + 2 * padding)
                    
                    let path = UIBezierPath(rect: borderFrame).CGPath
                    CGContextAddPath(context, path)
                    CGContextDrawPath(context, .Stroke)
                }
            }
        }
        
        // Draw grid
        
        let tableFrame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + headerSpace, width: totalWidth, height: y - contentHeight)
        CGContextStrokeRect(context, tableFrame)
        
        // Change colors to draw fill instead of stroke
        
        CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 0.0)
        CGContextSetFillColorWithColor(context, lineColor.CGColor)
        
        // Draw vertical lines
        var lineX: CGFloat = 0
        for width in relativeColumnWidth.dropLast() {
            lineX += width
            let drawRect = CGRect(x: tableFrame.minX + lineX * totalWidth, y: tableFrame.minY, width: lineWidth, height: tableFrame.height)
            let path = UIBezierPath(rect: drawRect).CGPath
            
            CGContextAddPath(context, path)
            CGContextDrawPath(context, .Fill)
        }
        
        // Draw horizontal lines
        var lineY: CGFloat = 0
        for (rowIdx, _) in frames.dropLast().enumerate() {
            var maxHeight: CGFloat = 0
            for col in frames[rowIdx] {
                maxHeight = max(maxHeight, col.height)
            }
            
            lineY += maxHeight + 2 * margin + 2 * padding
            
            let drawRect = CGRect(x: tableFrame.minX, y: tableFrame.minY + lineY, width: tableFrame.width, height: lineWidth)
            let path = UIBezierPath(rect: drawRect).CGPath
            
            CGContextAddPath(context, path)
            CGContextDrawPath(context, .Fill)
        }
        
        contentHeight = tableFrame.maxY - maxHeaderHeight() - headerSpace
    }
    
    private func calculateCellFrame(origin: CGPoint, width: CGFloat, text: NSString, alignment: TableCellAlignment, attributes: [String: AnyObject]) -> CGRect {
        let rect = CGRect(origin: origin, size: CGSize(width: width, height: 0))
        
        let size = text.sizeWithAttributes(attributes)
        let x: CGFloat = {
            switch alignment.normalizeHorizontal {
            case .Center:
                return rect.midX - size.width / 2
            case .Right:
                return rect.maxX - size.width
            default:
                return rect.minX
            }
        }()
        return CGRect(origin: CGPoint(x: x, y: origin.y), size: size)
    }
    
    // MARK: - Tools
    
    private func resetHeaderFooterHeight() {
        headerHeight[.HeaderLeft] = headerMargin
        headerHeight[.HeaderCenter] = headerMargin
        headerHeight[.HeaderRight] = headerMargin
        
        footerHeight[.FooterLeft] = footerMargin
        footerHeight[.FooterCenter] = footerMargin
        footerHeight[.FooterRight] = footerMargin
    }
    
    private func maxHeaderHeight() -> CGFloat {
        return max(pageMargin, max(headerHeight[.HeaderLeft]!, max(headerHeight[.HeaderCenter]!, headerHeight[.HeaderRight]!)))
    }
    
    private func maxFooterHeight() -> CGFloat {
        return max(pageMargin, max(footerHeight[.FooterLeft]!, max(footerHeight[.FooterCenter]!, footerHeight[.FooterRight]!)))
    }
    
    private func renderHeaderFooter(repeated: Bool = false) {
        resetHeaderFooterHeight()
        
        for (container, command) in headerFooterCommands {
            renderCommand(container, command: command)
        }
    }
    
    private func renderCommand(container: Container, command: Command) {
        switch command {
        case let .AddText(text, spacing):
            drawText(container, text: text, font: font, spacing: spacing)
            break
        case let .AddAttributedText(text):
            drawAttributedText(container, text: text)
            break
        case let .AddImage(image, size):
            drawImage(container, image: image, size: size)
            break
        case let .AddSpace(space):
            if container.isHeader {
                headerHeight[container] = headerHeight[container]! + space
            } else if container.isFooter {
                footerHeight[container] = footerHeight[container]! + space
            } else {
                contentHeight += space
            }
            break
        case let .AddLineSeparator(width, color):
            drawLineSeparator(container, thickness: width, color: color)
        case let .AddTable(data, alignment, relativeWidth, padding, margin, textColor, lineColor, lineWidth, drawCellBounds):
            drawTable(container, data: data, alignments: alignment, relativeColumnWidth: relativeWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds)
        case let .SetIndentation(value):
            indentation[container.normalize] = value
        case let .SetOffset(value):
            if container.isHeader {
                headerHeight[container] = value
            } else if container.isFooter {
                footerHeight[container] = value
            } else {
                contentHeight = value
            }
            break
        }
    }
}
