//
//  PDFGenerator.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 11/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit

open class PDFGenerator  {
    
    // MARK: - Public Variables
    
    static let headerImageHeight: CGFloat = 32
    
    open var pageBounds: CGRect = CGRect.zero
    open var pageMargin: CGFloat = 0
    
    open var headerMargin: CGFloat = 0
    open var footerMargin: CGFloat = 0
    
    open var headerSpace: CGFloat = 0
    open var footerSpace: CGFloat = 0
    
    // MARK: - Private Variables
    
    fileprivate var commands: [(Container, Command)] = []
    
    fileprivate var headerHeight: [Container : CGFloat] = [:]
    fileprivate var footerHeight: [Container : CGFloat] = [:]
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentSize: CGSize {
        return CGSize(width: pageBounds.width - 2 * pageMargin, height: pageBounds.height - maxHeaderHeight() - headerSpace - maxFooterHeight() - footerSpace)
    }
    
    fileprivate var paginationContainer = Container.none
    fileprivate var page = 1
    
    fileprivate var imageQuality: CGFloat = 0.8 {
        didSet {
            if imageQuality > 1 {
                imageQuality = 1
            }
        }
    }
    
    fileprivate var headerFooterCommands: [(Container, Command)] = []
    fileprivate let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    
    fileprivate var indentation: [Container: CGFloat] = [
        .headerLeft : 0,
        .contentLeft : 0,
        .footerLeft : 0
    ]
    
    // MARK: - Initializing
    
    public init(pageSize: CGSize, pageMargin: CGFloat = 36.0, headerMargin: CGFloat = 20.0, footerMargin: CGFloat = 20.0, headerSpace: CGFloat = 8, footerSpace: CGFloat = 8, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8) {
        pageBounds = CGRect(origin: CGPoint.zero, size: pageSize)
        self.pageMargin = pageMargin
        
        self.footerMargin = footerMargin
        self.headerMargin = headerMargin
        
        self.headerSpace = headerSpace
        self.footerSpace = footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        resetHeaderFooterHeight()
    }
    
    public init(format: PageFormat, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8) {
        pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        pageMargin = format.margin
        
        footerMargin = format.footerMargin
        headerMargin = format.headerMargin
        
        headerSpace = format.headerSpace
        footerSpace = format.footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        resetHeaderFooterHeight()
    }
    
    // MARK: - Preparation
    
    open func addText(_ container: Container = Container.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        commands += [(container, .addText(text: text, lineSpacing: lineSpacing)) ]
    }
    
    open func addAttributedText(_ container: Container = Container.contentLeft, text: NSAttributedString) {
        commands += [(container, .addAttributedText(text: text)) ]
    }
    
    open func addImage(_ container: Container = Container.contentLeft, image: UIImage, size: CGSize = CGSize.zero, caption: NSAttributedString = NSAttributedString()) {
        commands += [(container, .addImage(image: image, size: size, caption: caption))]
    }
    
    open func addImagesInRow(_ container: Container = Container.contentLeft, images: [UIImage], captions: [NSAttributedString] = [], spacing: CGFloat = 5.0) {
        commands += [(container, .addImagesInRow(images: images, captions: captions, spacing: spacing))]
    }
    
    open func addSpace(_ container: Container = Container.contentLeft, space: CGFloat) {
        commands += [(container, .addSpace(space: space))]
    }
    
    open func addLineSeparator(_ container: Container = Container.contentLeft, thickness: CGFloat = 1.0, color: UIColor = UIColor.black) {
        commands += [(container, .addLineSeparator(thickness: thickness, color: color))]
    }
    
    open func addTable(_ container: Container = Container.contentLeft, data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat = 0, margin: CGFloat = 0, textColor: UIColor = UIColor.black, lineColor: UIColor = UIColor.darkGray, lineWidth: CGFloat = 1.0, drawCellBounds: Bool = false) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignment.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerated() {
            assert(row.count == alignment[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        
        commands += [(container, .addTable(data: data, alignment: alignment, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds))]
    }
    
    open func setIndentation(_ container: Container = Container.contentLeft, indent: CGFloat) {
        commands += [(container, .setIndentation(points: indent))]
    }
    
    open func setAbsoluteOffset(_ container: Container = Container.contentLeft, offset: CGFloat) {
        commands += [(container, .setOffset(points: offset))]
    }
    
    open func createNewPage() {
        commands += [(.contentLeft, .createNewPage())]
    }
    
    // MARK: - Generation
    
    open func generatePDFdata(_ progress: ((CGFloat) -> ())? = nil) -> Data {
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
        
        for (idx, (container, command)) in contentCommands.enumerated() {
            renderCommand(container, command: command)
            progress?(CGFloat(idx + 1) / count)
        }
        
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }
    
    // MARK: - Rendering
    
    fileprivate func drawText(_ container: Container, text: String, font: UIFont, spacing: CGFloat, repeated: Bool = false, textMaxWidth: CGFloat = 0) {
        let attributes = generateDefaultTextAttributes(container, font: font, spacing: spacing)
        
        drawAttributedText(container, text: NSAttributedString(string: text, attributes: attributes), repeated: repeated, textMaxWidth: textMaxWidth)
    }
    
    fileprivate func drawAttributedText(_ container: Container, text: NSAttributedString, repeated: Bool = false, textMaxWidth: CGFloat = 0) {
        let currentText = CFAttributedStringCreateCopy(nil, text as CFAttributedString)
        let framesetter = CTFramesetterCreateWithAttributedString(currentText!)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        
        repeat {
            let (frameRef, drawnSize) = calculateOneLineTextFrameAndDrawnSize(container, framesetter: framesetter, currentRange: currentRange, textMaxWidth: textMaxWidth)
            // Get the graphics context.
            let currentContext = UIGraphicsGetCurrentContext()!
            
            // Push state
            currentContext.saveGState()
            
            // Put the text matrix into a known state. This ensures
            // that no old scaling factors are left in place.
            currentContext.textMatrix = CGAffineTransform.identity
            
            // Core Text draws from the bottom-left corner up, so flip
            // the current transform prior to drawing.
            currentContext.translateBy(x: 0, y: pageBounds.height)
            currentContext.scaleBy(x: 1.0, y: -1.0)
            
            // Draw the frame.
            CTFrameDraw(frameRef, currentContext)
            
            // Pop state
            currentContext.restoreGState()
            
            // Update the current range based on what was drawn.
            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
            currentRange = CFRange(location: visibleRange.location + visibleRange.length , length: 0)
            
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
                generateNewPage()
            }
        } while(!done)
    }
    
    fileprivate func drawImage(_ container: Container, image: UIImage, frame: CGRect, caption: NSAttributedString) {
        // resize
        let resizeFactor = (3 * imageQuality > 1) ? 3 * imageQuality : 1
        let resizeImageSize = CGSize(width: frame.size.width * resizeFactor, height: frame.size.height * resizeFactor)
        UIGraphicsBeginImageContext(resizeImageSize)
        image.draw(in: CGRect(x:0, y:0, width: resizeImageSize.width, height: resizeImageSize.height))
        var compressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // compression
        if let image = compressedImage, let jpegData = UIImageJPEGRepresentation(image, imageQuality) {
            compressedImage = UIImage(data: jpegData)
        }
     
        if let resultImage = compressedImage {
            resultImage.draw(in: frame)
        }
        else {
            image.draw(in: frame)
        }
        
        if container.isHeader {
            headerHeight[container] = headerHeight[container]! + frame.height
        } else if container.isFooter {
            footerHeight[container] = footerHeight[container]! + frame.height
        } else {
            contentHeight += frame.height
        }
        
        if caption.length > 0 {
            drawAttributedText(container, text: caption, textMaxWidth: frame.size.width)
        }
    }
    
    fileprivate func drawImage(_ container: Container, image: UIImage, size: CGSize, caption: NSAttributedString) {
        var (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption)
    
        var y: CGFloat = {
            switch container.normalize {
            case .headerLeft:
                return headerHeight[container]!
            case .contentLeft:
                var y = contentHeight + maxHeaderHeight() + headerSpace
                if (y + imageSize.height + captionSize.height > contentSize.height) {
                    generateNewPage()
                    
                    (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption)
                    y = contentHeight + maxHeaderHeight() + headerSpace
                }
                return y
            case .footerLeft:
                return contentSize.height + maxHeaderHeight() + footerHeight[container]!
            default:
                return 0
            }
        }()
        
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return pageMargin + indentation[container.normalize]!
            case .headerCenter, .contentCenter, .footerCenter:
                return pageBounds.midX - imageSize.width / 2
            case .headerRight, .contentRight, .footerRight:
                return pageBounds.width - pageMargin - imageSize.width
            default:
                return 0
            }
        }()
        
        let frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
        drawImage(container, image: image, frame: frame, caption: caption)
    }
    
    fileprivate func drawImagesInRow(_ container: Container, images: [UIImage], captions: [NSAttributedString], spacing: CGFloat) {
        if (images.count <= 0) {
            return
        }
        
        let totalimagesWidth = contentSize.width - indentation[container.normalize]! - (CGFloat(images.count) - 1) * spacing
        
        let imageWidth = totalimagesWidth / CGFloat(images.count)
        
        let calculateImageCaptionSizes: ([UIImage], [NSAttributedString]) -> ([CGSize], CGFloat) = {
            images, captions in
            
            var (imageSizes, maxHeight): ([CGSize], CGFloat) = ([], 0)
            for (index, image) in images.enumerated() {
                let caption = (captions.count > index) ? captions[index] : NSAttributedString()
                let (imageSize, captionSize) = self.calculateImageCaptionSize(container, image: image, size: CGSize(width: imageWidth, height: image.size.height), caption: caption)
                imageSizes.append(imageSize)
                
                if maxHeight < imageSize.height + captionSize.height {
                    maxHeight = imageSize.height + captionSize.height
                }
            }
            
            return (imageSizes, maxHeight)
        }
        
        var (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)

        var y = contentHeight + maxHeaderHeight() + headerSpace
        if (y + maxHeight > contentSize.height) {
            generateNewPage()
            
            y = contentHeight + maxHeaderHeight() + headerSpace
            (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)
        }
        
        var x: CGFloat = pageMargin + indentation[container.normalize]!
        
        let (nowContentHeight, nowIndentation) = (contentHeight, indentation[container.normalize]!)
        for (index, image) in images.enumerated() {
            let imageSize = imageSizes[index]
            let caption = (captions.count > index) ? captions[index] : NSAttributedString()
            drawImage(container, image: image, frame: CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height), caption: caption)
            
            x += imageSize.width + spacing
            indentation[container.normalize] = indentation[container.normalize]! + imageSize.width + spacing
            contentHeight = nowContentHeight
        }
        
        indentation[container.normalize] = nowIndentation
        contentHeight += maxHeight
    }
    
    fileprivate func drawLineSeparator(_ container: Container, thickness: CGFloat, color: UIColor) {
        let y: CGFloat = {
            switch container.normalize {
            case .headerLeft:
                return maxHeaderHeight() + 4
            case .contentLeft:
                return contentHeight + maxHeaderHeight() + headerSpace
            case .footerLeft:
                return contentSize.height + maxHeaderHeight() + headerSpace + footerSpace - 4
            default:
                return 0
            }
        }()
        
        let drawRect = CGRect(x: pageMargin + indentation[container.normalize]!, y: y, width: contentSize.width -  indentation[container.normalize]!, height: thickness)
        let path = UIBezierPath(rect: drawRect).cgPath
        
        // Get the graphics context.
        let currentContext = UIGraphicsGetCurrentContext()!
        
        // Set color
        color.setStroke()
        color.setFill()
        
        // Draw path
        currentContext.addPath(path)
        currentContext.drawPath(using: .fillStroke)
    }
    
    fileprivate func drawTable(_ container: Container, data: [[String]], alignments: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, textColor: UIColor, lineColor: UIColor, lineWidth: CGFloat, drawCellBounds: Bool) {
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
        
        var frames: [[CGRect]] = []
        
        let attributes: [String: AnyObject] = [
            NSForegroundColorAttributeName: textColor,
            NSFontAttributeName: font
        ]
        
        for (rowIdx, row) in data.enumerated() {
            frames.append([])
            
            x += margin + padding
            y += margin + padding
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X position and size
            for (colIdx, column) in row.enumerated() {
                let width = relativeColumnWidth[colIdx] * totalWidth
                let result = calculateCellFrame(CGPoint(x: x, y: y + maxHeaderHeight() + headerSpace), width: width - 2 * margin - 2 * padding, text: column as NSString, alignment: alignments[rowIdx][colIdx], attributes: attributes)
                x += width
                maxHeight = max(maxHeight, result.height)
                frames[rowIdx].append(result)
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
            y += maxHeight + margin + padding
        }
        
        // Draw text
        
        for (rowIdx, row) in data.enumerated() {
            for (colIdx, text) in row.enumerated() {
                let frame = frames[rowIdx][colIdx]
                text.draw(at: frame.origin, withAttributes: attributes)
            }
        }
        
        // Begin drawing grid
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(lineWidth)
        
        // Draw cell bounding box
        
        if drawCellBounds {
            for (rowIdx, row) in data.enumerated() {
                for (colIdx, _) in row.enumerated() {
                    let frame = frames[rowIdx][colIdx]
                    let borderFrame = CGRect(x: frame.minX - padding, y: frame.minY - padding, width: frame.width + 2 * padding, height: frame.height + 2 * padding)
                    
                    let path = UIBezierPath(rect: borderFrame).cgPath
                    context?.addPath(path)
                    context?.drawPath(using: .stroke)
                }
            }
        }
        
        // Draw grid
        
        let tableFrame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + headerSpace, width: totalWidth, height: y - contentHeight)
        context?.stroke(tableFrame)
        
        // Change colors to draw fill instead of stroke
        
        context?.setStrokeColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        context?.setFillColor(lineColor.cgColor)
        
        // Draw vertical lines
        var lineX: CGFloat = 0
        for width in relativeColumnWidth.dropLast() {
            lineX += width
            let drawRect = CGRect(x: tableFrame.minX + lineX * totalWidth, y: tableFrame.minY, width: lineWidth, height: tableFrame.height)
            let path = UIBezierPath(rect: drawRect).cgPath
            
            context?.addPath(path)
            context?.drawPath(using: .fill)
        }
        
        // Draw horizontal lines
        var lineY: CGFloat = 0
        for (rowIdx, _) in frames.dropLast().enumerated() {
            var maxHeight: CGFloat = 0
            for col in frames[rowIdx] {
                maxHeight = max(maxHeight, col.height)
            }
            
            lineY += maxHeight + 2 * margin + 2 * padding
            
            let drawRect = CGRect(x: tableFrame.minX, y: tableFrame.minY + lineY, width: tableFrame.width, height: lineWidth)
            let path = UIBezierPath(rect: drawRect).cgPath
            
            context?.addPath(path)
            context?.drawPath(using: .fill)
        }
        
        contentHeight = tableFrame.maxY - maxHeaderHeight() - headerSpace
    }
    
    fileprivate func calculateCellFrame(_ origin: CGPoint, width: CGFloat, text: NSString, alignment: TableCellAlignment, attributes: [String: AnyObject]) -> CGRect {
        let rect = CGRect(origin: origin, size: CGSize(width: width, height: 0))
        
        let size = text.size(attributes: attributes)
        let x: CGFloat = {
            switch alignment.normalizeHorizontal {
            case .center:
                return rect.midX - size.width / 2
            case .right:
                return rect.maxX - size.width
            default:
                return rect.minX
            }
        }()
        return CGRect(origin: CGPoint(x: x, y: origin.y), size: size)
    }
    
    fileprivate func calculateOneLineTextFrameAndDrawnSize(_ container: Container, framesetter: CTFramesetter, currentRange: CFRange, textMaxWidth: CGFloat) -> (CTFrame, CGSize) {
        let textMaxWidth = (textMaxWidth > 0) ? textMaxWidth : pageBounds.width - 2 * pageMargin - indentation[container.normalize]!
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
        let x: CGFloat = {
            switch container {
            case .headerLeft, .contentLeft, .footerLeft:
                return pageMargin + indentation[container.normalize]!
            case .headerCenter, .contentCenter, .footerCenter:
                return pageBounds.midX - textMaxWidth / 2
            case .headerRight, .contentRight, .footerRight:
                return pageBounds.width - pageMargin - textMaxWidth
            default:
                return 0
            }
        }()
        
        let frame: CGRect = {
            if container.isHeader {
                return CGRect(x: x, y: 0, width: textMaxWidth, height: textMaxHeight)
            } else if container.isFooter {
                return CGRect(x: x, y: footerHeight[container]!, width: textMaxWidth, height: textMaxHeight)
            } else {
                return CGRect(x: x, y: maxFooterHeight() + footerSpace, width: textMaxWidth, height: textMaxHeight)
            }
        }()
        let framePath = UIBezierPath(rect: frame).cgPath
        
        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        let frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
        
        // Update the current range based on what was drawn.
        let visibleRange = CTFrameGetVisibleStringRange(frameRef)
        
        // Update last drawn frame
        let constraintSize = CGSize(width: textMaxWidth, height: textMaxHeight)
        let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, constraintSize, nil)
        
        return (frameRef, drawnSize)
    }
    
    fileprivate func calculateAttributedTextHeight(_ container: Container, text: NSAttributedString, textMaxWidth: CGFloat) -> CGFloat {
        let currentText = CFAttributedStringCreateCopy(nil, text as CFAttributedString)
        let framesetter = CTFramesetterCreateWithAttributedString(currentText!)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        var height: CGFloat = 0
        
        repeat {
            let (frameRef, drawnSize) = calculateOneLineTextFrameAndDrawnSize(container, framesetter: framesetter, currentRange: currentRange, textMaxWidth: textMaxWidth)
            
            // Update the current range based on what was drawn.
            let visibleRange = CTFrameGetVisibleStringRange(frameRef)
            currentRange = CFRange(location: visibleRange.location + visibleRange.length , length: 0)
            
            height += drawnSize.height
            
            if currentRange.location == CFAttributedStringGetLength(currentText){
                done = true
            }
        } while(!done)
        
        return height
    }
    
    fileprivate func calculateImageCaptionSize(_ container: Container, image: UIImage, size: CGSize, caption: NSAttributedString) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        var size = (size == CGSize.zero) ? image.size : size
        if container.isHeader || container.isFooter {
            size = CGSize(width: PDFGenerator.headerImageHeight, height: PDFGenerator.headerImageHeight)
        }
        
        let maxWidth = min(size.width, contentSize.width - indentation[container.normalize]!)
        let maxHeight = min(size.height, contentSize.height - contentHeight)
        
        let wFactor = image.size.width / maxWidth
        let hFactor = image.size.height / maxHeight
        let factor = max(wFactor, hFactor)
        
        let imageSize = CGSize(width: image.size.width / factor, height: image.size.height / factor)
        
        var (captionText, captionHeight) = (NSAttributedString(), CGFloat(0))
        if caption.length > 0 {
            captionHeight = calculateAttributedTextHeight(container, text: caption, textMaxWidth: imageSize.width)
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionHeight))
    }
    
    // MARK: - Tools
    
    fileprivate func resetHeaderFooterHeight() {
        headerHeight[.headerLeft] = headerMargin
        headerHeight[.headerCenter] = headerMargin
        headerHeight[.headerRight] = headerMargin
        
        footerHeight[.footerLeft] = footerMargin
        footerHeight[.footerCenter] = footerMargin
        footerHeight[.footerRight] = footerMargin
    }
    
    fileprivate func maxHeaderHeight() -> CGFloat {
        return max(pageMargin, max(headerHeight[.headerLeft]!, max(headerHeight[.headerCenter]!, headerHeight[.headerRight]!)))
    }
    
    fileprivate func maxFooterHeight() -> CGFloat {
        return max(pageMargin, max(footerHeight[.footerLeft]!, max(footerHeight[.footerCenter]!, footerHeight[.footerRight]!)))
    }
    
    fileprivate func generateDefaultTextAttributes(_ container: Container, font: UIFont, spacing: CGFloat) -> [String: NSObject] {
        let paragraphStyle = NSMutableParagraphStyle()
        switch container {
        case .headerLeft, .contentLeft, .footerLeft:
            paragraphStyle.alignment = .left
        case .headerCenter, .contentCenter, .footerCenter:
            paragraphStyle.alignment = .center
        case .headerRight, .contentRight, .footerRight:
            paragraphStyle.alignment = .right
        default:
            paragraphStyle.alignment = .left
        }
        
        paragraphStyle.lineSpacing = spacing
        
        return [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: paragraphStyle
        ]
    }
    
    fileprivate func renderHeaderFooter(_ repeated: Bool = false) {
        resetHeaderFooterHeight()
        
        if paginationContainer != .none {
            renderCommand(paginationContainer, command: .addText(text: String(page), lineSpacing: 1.0))
        }
        
        for (container, command) in headerFooterCommands {
            renderCommand(container, command: command)
        }
    }
    
    fileprivate func generateNewPage() {
        UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
        contentHeight = 0
        page += 1
        
        renderHeaderFooter()
    }
    
    fileprivate func renderCommand(_ container: Container, command: Command) {
        switch command {
        case let .addText(text, spacing):
            drawText(container, text: text, font: font, spacing: spacing)
            break
        case let .addAttributedText(text):
            drawAttributedText(container, text: text)
            break
        case let .addImage(image, size, caption):
            drawImage(container, image: image, size: size, caption: caption)
            break
        case let .addImagesInRow(images, captions, spacing):
            drawImagesInRow(container, images: images, captions: captions, spacing: spacing)
            break
        case let .addSpace(space):
            if container.isHeader {
                headerHeight[container] = headerHeight[container]! + space
            } else if container.isFooter {
                footerHeight[container] = footerHeight[container]! + space
            } else {
                contentHeight += space
            }
            break
        case let .addLineSeparator(width, color):
            drawLineSeparator(container, thickness: width, color: color)
        case let .addTable(data, alignment, relativeWidth, padding, margin, textColor, lineColor, lineWidth, drawCellBounds):
            drawTable(container, data: data, alignments: alignment, relativeColumnWidth: relativeWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds)
        case let .setIndentation(value):
            indentation[container.normalize] = value
        case let .setOffset(value):
            if container.isHeader {
                headerHeight[container] = value
            } else if container.isFooter {
                footerHeight[container] = value
            } else {
                contentHeight = value
            }
            break
        case let .createNewPage():
            generateNewPage()
        }
    }
}
