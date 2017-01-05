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
    
    open var headerImageHeight: CGFloat = 32
    
    open var pageBounds: CGRect = CGRect.zero
    open var pageMargin: CGFloat = 0
    
    open var headerMargin: CGFloat = 0
    open var footerMargin: CGFloat = 0
    
    open var headerSpace: CGFloat = 0
    open var footerSpace: CGFloat = 0
    
    open var info: PDFInfo = PDFInfo()
    
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
    
    public init(pageSize: CGSize, pageMargin: CGFloat = 36.0, headerMargin: CGFloat = 20.0, footerMargin: CGFloat = 20.0, headerSpace: CGFloat = 8, footerSpace: CGFloat = 8, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        pageBounds = CGRect(origin: CGPoint.zero, size: pageSize)
        self.pageMargin = pageMargin
        
        self.footerMargin = footerMargin
        self.headerMargin = headerMargin
        
        self.headerSpace = headerSpace
        self.footerSpace = footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
    
    public init(format: PageFormat, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        pageMargin = format.margin
        
        footerMargin = format.footerMargin
        headerMargin = format.headerMargin
        
        headerSpace = format.headerSpace
        footerSpace = format.footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
    
    // MARK: - Preparation
    
    open func addText(_ container: Container = Container.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        commands += [(container, .addText(text: text, lineSpacing: lineSpacing))]
    }
    
    open func addAttributedText(_ container: Container = Container.contentLeft, text: NSAttributedString) {
        commands += [(container, .addAttributedText(text: text))]
    }
    
    open func addImage(_ container: Container = Container.contentLeft, image: UIImage, size: CGSize = CGSize.zero, caption: NSAttributedString = NSAttributedString(), sizeFit: ImageSizeFit = .widthHeight) {
        commands += [(container, .addImage(image: image, size: size, caption: caption, sizeFit: sizeFit))]
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
    
    open func addTable(_ container: Container = Container.contentLeft, data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat = 0, margin: CGFloat = 0, textColor: UIColor = UIColor.black, lineColor: UIColor = UIColor.darkGray, lineWidth: CGFloat = 1.0, drawCellBounds: Bool = false, textFont: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignment.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerated() {
            assert(row.count == alignment[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        
        commands += [(container, .addTable(data: data, alignment: alignment, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds, textFont: textFont))]
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
        
        UIGraphicsBeginPDFContextToData(pdfData, pageBounds, generateDocumentInfo())
        generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }
    
    open func generatePDFfile(_ fileName: String, progress: ((CGFloat) -> ())? = nil) -> URL {
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName).appendingPathExtension("pdf")
        
        
        UIGraphicsBeginPDFContextToFile(url.path, pageBounds, generateDocumentInfo())
        generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
        
        return url;
    }
    
    fileprivate func generatePDFContext(progress: ((CGFloat) -> ())?) {
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
            autoreleasepool {
                renderCommand(container, command: command)
                progress?(CGFloat(idx + 1) / count)
            }
        }
    }
    
    // MARK: - Rendering
    
    fileprivate func drawText(_ container: Container, text: String, font: UIFont, spacing: CGFloat, repeated: Bool = false, textMaxWidth: CGFloat = 0) {
        let attributes = generateDefaultTextAttributes(container, font: font, spacing: spacing)
        
        drawAttributedText(container, text: NSAttributedString(string: text, attributes: attributes), repeated: repeated, textMaxWidth: textMaxWidth)
    }
    
    fileprivate func drawAttributedText(_ container: Container, text: NSAttributedString, repeated: Bool = false, textMaxWidth: CGFloat = 0) {
        let currentText = CFAttributedStringCreateCopy(nil, text as CFAttributedString)
        var currentRange = CFRange(location: 0, length: 0)
        var done = false
        
        repeat {
            let (frameRef, drawnSize) = calculateTextFrameAndDrawnSizeInOnePage(container, text: currentText!, currentRange: currentRange, textMaxWidth: textMaxWidth)
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
            if currentRange.location == CFAttributedStringGetLength(currentText) {
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
    
    fileprivate func drawImage(_ container: Container, image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit) {
        var (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
    
        let y: CGFloat = {
            switch container.normalize {
            case .headerLeft:
                return headerHeight[container]!
            case .contentLeft:
                if (contentHeight + imageSize.height + captionSize.height > contentSize.height || (sizeFit == .height && imageSize.height < size.height)) {
                    generateNewPage()
                    
                    (imageSize, captionSize) = calculateImageCaptionSize(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
                    
                    return contentHeight + maxHeaderHeight() + headerSpace
                }
                return contentHeight + maxHeaderHeight() + headerSpace
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
        
        let totalImagesWidth = contentSize.width - indentation[container.normalize]! - (CGFloat(images.count) - 1) * spacing
        let imageWidth = totalImagesWidth / CGFloat(images.count)
        
        let calculateImageCaptionSizes: ([UIImage], [NSAttributedString]) -> ([CGSize], CGFloat) = {
            images, captions in
            
            var (imageSizes, maxHeight): ([CGSize], CGFloat) = ([], 0)
            for (index, image) in images.enumerated() {
                let caption = (captions.count > index) ? captions[index] : NSAttributedString()
                let (imageSize, captionSize) = self.calculateImageCaptionSize(container, image: image, size: CGSize(width: imageWidth, height: image.size.height), caption: caption, sizeFit: .width)
                imageSizes.append(imageSize)
                
                if maxHeight < imageSize.height + captionSize.height {
                    maxHeight = imageSize.height + captionSize.height
                }
            }
            
            return (imageSizes, maxHeight)
        }
        
        var (imageSizes, maxHeight) = calculateImageCaptionSizes(images, captions)

        var y = contentHeight + maxHeaderHeight() + headerSpace
        if (contentHeight + maxHeight > contentSize.height) {
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
    
    fileprivate func drawTable(_ container: Container, data: [[String]], alignments: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, textColor: UIColor, lineColor: UIColor, lineWidth: CGFloat, drawCellBounds: Bool, textFont: UIFont) {
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
            NSFontAttributeName: textFont
        ]
        
        for (rowIdx, row) in data.enumerated() {
            frames.append([])
            
            x += margin + padding
            y += margin + padding
            
            var maxHeight: CGFloat = 0
            
            // Calcuate X position and size
            for (colIdx, column) in row.enumerated() {
                let text = NSAttributedString(string: column, attributes: attributes)
                let width = relativeColumnWidth[colIdx] * totalWidth
                let result = calculateCellFrame(CGPoint(x: x, y: y + maxHeaderHeight() + headerSpace), width: width - 2 * margin - 2 * padding, text: text, alignment: alignments[rowIdx][colIdx])
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
        
        // Divide tables according to contentSize
        var (dataInThisPage, alignmentsInThisPage, framesInThisPage): ([[String]], [[TableCellAlignment]], [[CGRect]]) = ([], [], [])
        var (dataInNewPage, alignmentsInNewPage): ([[String]], [[TableCellAlignment]]) = ([], [])
        var totalHeight: CGFloat = 0
        for (rowIdx, row) in data.enumerated() {
            let maxHeight = frames[rowIdx].reduce(0) { max($0, $1.height) }
            let cellHeight = maxHeight + 2 * margin + 2 * padding
            if (frames[rowIdx][0].origin.y + cellHeight > contentSize.height + maxHeaderHeight() + headerSpace) {
                dataInNewPage.append(row)
                alignmentsInNewPage.append(alignments[rowIdx])
            }
            else {
                dataInThisPage.append(row)
                alignmentsInThisPage.append(alignments[rowIdx])
                framesInThisPage.append(frames[rowIdx])
                
                totalHeight += cellHeight
            }
        }
        
        // Draw text
        
        for (rowIdx, row) in dataInThisPage.enumerated() {
            for (colIdx, text) in row.enumerated() {
                let frame = framesInThisPage[rowIdx][colIdx]
                let attributedText = NSAttributedString(string: text, attributes: attributes)
                // the last line of text is hidden if 30 is not added
                attributedText.draw(in: CGRect(origin: frame.origin, size: CGSize(width: frame.width, height:frame.height + 20)))
            }
        }
        
        // Begin drawing grid
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
        context?.setStrokeColor(lineColor.cgColor)
        context?.setLineWidth(lineWidth)
        
        // Draw cell bounding box
        
        if drawCellBounds {
            for (rowIdx, row) in dataInThisPage.enumerated() {
                for (colIdx, _) in row.enumerated() {
                    let frame = framesInThisPage[rowIdx][colIdx]
                    let borderFrame = CGRect(x: frame.minX - padding, y: frame.minY - padding, width: frame.width + 2 * padding, height: frame.height + 2 * padding)
                    
                    let path = UIBezierPath(rect: borderFrame).cgPath
                    context?.addPath(path)
                    context?.drawPath(using: .stroke)
                }
            }
        }
        
        // Draw grid
        
        let tableFrame = CGRect(x: x, y: contentHeight + maxHeaderHeight() + headerSpace, width: totalWidth, height: totalHeight)
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
        for (rowIdx, frame) in framesInThisPage.dropLast().enumerated() {
            var maxHeight: CGFloat = frame.reduce(0) { max($0, $1.height) }
            
            lineY += maxHeight + 2 * margin + 2 * padding
            
            let drawRect = CGRect(x: tableFrame.minX, y: tableFrame.minY + lineY, width: tableFrame.width, height: lineWidth)
            let path = UIBezierPath(rect: drawRect).cgPath
            
            context?.addPath(path)
            context?.drawPath(using: .fill)
        }
        
        if !dataInNewPage.isEmpty {
            generateNewPage()
            drawTable(container, data: dataInNewPage, alignments: alignmentsInNewPage, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds, textFont: textFont)
        }
        else {
            contentHeight = tableFrame.maxY - maxHeaderHeight() - headerSpace
        }
    }
    
    fileprivate func calculateCellFrame(_ origin: CGPoint, width: CGFloat, text: NSAttributedString, alignment: TableCellAlignment) -> CGRect {
        let textMaxHeight = pageBounds.height - maxHeaderHeight() - headerSpace - maxFooterHeight() - footerSpace - contentHeight
        // The height is not enough
        if (textMaxHeight <= 0) {
            return CGRect.infinite
        }
        let frame: CGRect = CGRect(x: origin.x, y: origin.y, width: width, height: textMaxHeight)
        
        var currentRange = CFRange(location: 0, length: 0)
        let (_, drawnSize) = calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
        let x: CGFloat = {
            switch alignment.normalizeHorizontal {
            case .center:
                return origin.x + width / 2 - drawnSize.width / 2
            case .right:
                return origin.x + width - drawnSize.width
            default:
                return origin.x
            }
        }()

        return CGRect(origin: CGPoint(x: x, y: origin.y), size: CGSize(width: drawnSize.width, height: drawnSize.height))
    }
    
    fileprivate func calculateTextFrameAndDrawnSizeInOnePage(frame: CGRect, text: CFAttributedString, currentRange: CFRange) -> (CTFrame, CGSize) {
        
        let framesetter = CTFramesetterCreateWithAttributedString(text)
        let framePath = UIBezierPath(rect: frame).cgPath
        
        // Get the frame that will do the rendering.
        // The currentRange variable specifies only the starting point. The framesetter
        // lays out as much text as will fit into the frame.
        let frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, nil)
        
        // Update the current range based on what was drawn.
        let visibleRange = CTFrameGetVisibleStringRange(frameRef)
        
        // Update last drawn frame
        let constraintSize = frame.size
        let drawnSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, visibleRange, nil, constraintSize, nil)
        
        return (frameRef, drawnSize)
    }
    
    fileprivate func calculateTextFrameAndDrawnSizeInOnePage(_ container: Container, text: CFAttributedString, currentRange: CFRange, textMaxWidth: CGFloat) -> (CTFrame, CGSize) {
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
        
        return calculateTextFrameAndDrawnSizeInOnePage(frame: frame, text: text, currentRange: currentRange)
    }
    
    fileprivate func calculateImageCaptionSize(_ container: Container, image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit) -> (CGSize, CGSize) {
        /* calculate the aspect size of image */
        var size = (size == CGSize.zero) ? image.size : size
        if container.isHeader || container.isFooter {
            size = CGSize(width: headerImageHeight, height: headerImageHeight)
        }
        
        let maxWidth = min(size.width, contentSize.width - indentation[container.normalize]!)
        let maxHeight = min(size.height, contentSize.height - contentHeight)
        
        let wFactor = image.size.width / maxWidth
        let hFactor = image.size.height / maxHeight
        let factor: CGFloat = {
            switch sizeFit {
            case .width:
                return wFactor
            case .height:
                return hFactor
            case .widthHeight:
                return max(wFactor, hFactor)
            default:
                return max(wFactor, hFactor)
            }
        }()
        
        let imageSize = CGSize(width: image.size.width / factor, height: image.size.height / factor)
        
        var (captionText, captionSize) = (NSAttributedString(), CGSize.zero)
        if caption.length > 0 {
            let currentText = CFAttributedStringCreateCopy(nil, caption as CFAttributedString)
            var currentRange = CFRange(location: 0, length: 0)
            (_, captionSize) = calculateTextFrameAndDrawnSizeInOnePage(container, text: currentText!, currentRange: currentRange, textMaxWidth: imageSize.width)
        }
        
        return (imageSize, CGSize(width: imageSize.width, height: captionSize.height))
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
        case let .addImage(image, size, caption, sizeFit):
            drawImage(container, image: image, size: size, caption: caption, sizeFit: sizeFit)
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
            break
        case let .addTable(data, alignment, relativeWidth, padding, margin, textColor, lineColor, lineWidth, drawCellBounds, textFont):
            drawTable(container, data: data, alignments: alignment, relativeColumnWidth: relativeWidth, padding: padding, margin: margin, textColor: textColor, lineColor: lineColor, lineWidth: lineWidth, drawCellBounds: drawCellBounds, textFont: textFont)
            break
        case let .setIndentation(value):
            indentation[container.normalize] = value
            break
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
            break
        }
    }
    
    fileprivate func generateDocumentInfo() -> [AnyHashable : Any] {
        var documentInfo: [AnyHashable : Any] = [
            kCGPDFContextTitle as String: info.title,
            kCGPDFContextAuthor as String: info.author,
            kCGPDFContextSubject as String: info.subject,
            kCGPDFContextKeywords as String: info.keywords,
            kCGPDFContextAllowsPrinting as String: info.allowsPrinting,
            kCGPDFContextAllowsCopying as String: info.allowsCopying]
        
        var creator = ""
        if let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            creator += bundleName
            
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                creator += " v" + version
            }
        }
        if !creator.isEmpty {
            documentInfo[kCGPDFContextCreator as String] = creator
        }
        
        if let ownerPassword = info.ownerPassword {
            documentInfo[kCGPDFContextOwnerPassword as String] = ownerPassword
        }
        
        if let userPassword = info.userPassword {
            documentInfo[kCGPDFContextUserPassword as String] = userPassword
        }
        
        return documentInfo
    }
}
