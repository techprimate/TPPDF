//
//  PDFGenerator+Generation.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    /// MARK: - Command Rendering
    
    func renderCommand(_ container: Container, command: Command, calculation: Bool = false) {
        switch command {
        case let .addText(text, spacing):
            drawText(container, text: text, spacing: spacing, calculation: calculation)
            break
        case let .addAttributedText(text):
            drawAttributedText(container, text: text, calculation: calculation)
            break
        case let .addImage(image, size, caption, sizeFit):
            drawImage(container, image: image, size: size, caption: caption, sizeFit: sizeFit, calculation: calculation)
            break
        case let .addImagesInRow(images, captions, spacing):
            drawImagesInRow(container, images: images, captions: captions, spacing: spacing, calculation: calculation)
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
            drawLineSeparator(container, style: style, calculation: calculation)
            break
        case let .addTable(data, alignment, relativeWidth, padding, margin, style):
            drawTable(container, data: data, alignments: alignment, relativeColumnWidth: relativeWidth, padding: padding, margin: margin, style: style, calculation: calculation)
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
            renderCommand(paginationContainer, command: .addText(text: paginationStyle.format(page: currentPage, total: totalPages), lineSpacing: 1.0))
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
        
        // Extract header & footer commands
        headerFooterCommands = commands.filter { return $0.0.isFooter || $0.0.isHeader }
        let contentCommands = commands.filter { return !$0.0.isFooter && !$0.0.isHeader }
        
        // Split header & footer commands
        let footers = commands.filter { return $0.0.isFooter }
        let headers = commands.filter { return $0.0.isHeader }
        
        // Only add space between content and footer if footer commands exist.
        if footers.count == 0 {
            footerSpace = 0
        }
        
        // Only add space between content and header if header commands exist.
        if headers.count == 0 {
            headerSpace = 0
        }
        
        // Progress equals the number of commands run. Each command is called once for calculations and second for rendering.
        var progressIndex: CGFloat = 0.0;
        let progressMax: CGFloat = CGFloat(contentCommands.count * 2)
        
        // Calculate metrics
        for (container, command) in contentCommands {
            autoreleasepool {
                renderCommand(container, command: command, calculation: true)
                progressIndex = progressIndex + 1;
                progress?(progressIndex / progressMax)
            }
        }
        
        totalPages = currentPage
        
        // Only render header & footer if page has content.
        if contentCommands.count > 0 {
            renderHeaderFooter()
        }
        
        // Render each command
        for (container, command) in contentCommands {
            autoreleasepool {
                renderCommand(container, command: command)
                progressIndex = progressIndex + 1;
                progress?(progressIndex / progressMax)
            }
        }
    }
}
