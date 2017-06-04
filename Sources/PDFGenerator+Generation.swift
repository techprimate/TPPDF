//
//  PDFGenerator+Generation.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    /// MARK: - Command Rendering
    
    func renderCommand(_ container: Container, command: Command) {
        switch command {
        case let .addText(text, spacing):
            drawText(container, text: text, spacing: spacing)
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
        case let .addLineSeparator(style):
            drawLineSeparator(container, style: style)
            break
        case let .addTable(data, alignment, relativeWidth, padding, margin, style):
            drawTable(container, data: data, alignments: alignment, relativeColumnWidth: relativeWidth, padding: padding, margin: margin, style: style)
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
        case let .setFont(font):
            fonts[container] = font
            break
        case .createNewPage():
            generateNewPage()
            break
        }
    }
    
    func renderHeaderFooter() {
        resetHeaderFooterHeight()
        
        if paginationContainer != .none {
            renderCommand(paginationContainer, command: .addText(text: String(page), lineSpacing: 1.0))
        }
        
        for (container, command) in headerFooterCommands {
            renderCommand(container, command: command)
        }
    }
    
    // MARK: - PDF Data Generation
    
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
}
