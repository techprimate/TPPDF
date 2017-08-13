//
//  PDFGenerator+Generation.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    /**
     Generates PDF data and writes it to a temporary file.
     
     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter filename:  Name of temporary file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - returns:             URL to temporary file.
     
     - throws:              PDFError
     */
    public static func generateURL(document: PDFDocument, filename: String, progress: ((CGFloat) -> ())? = nil) throws -> URL {
        let name = filename.hasSuffix(".pdf") ? filename : (filename + ".pdf")
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        let generator = PDFGenerator(document: document)
        
        UIGraphicsBeginPDFContextToFile(url.path, document.layout.pageBounds, document.info.generate())
        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
        
        return url;
    }
    
    /**
     Generates PDF data and returns it
     
     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - returns:             PDF Data
     
     - throws:              PDFError
     
     */
    public static func generateData(document: PDFDocument, progress: ((CGFloat) -> ())? = nil) throws -> Data {
        let data = NSMutableData()
        let generator = PDFGenerator(document: document)
        
        UIGraphicsBeginPDFContextToData(data, document.layout.pageBounds, document.info.generate())
        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
        
        return data as Data
    }
    
    /**
     Generate PDF Context from PDFCommands
     
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     
     - throws: PDFError
     */
    func generatePDFContext(progress: ((CGFloat) -> ())?) throws {
        UIGraphicsBeginPDFPageWithInfo(document.layout.pageBounds, nil)
        
        // Extract header & footer PDFCommands
        headerFooterObjects = document.objects.filter { return $0.0.isFooter || $0.0.isHeader }
        let contentObjects = document.objects.filter { return !$0.0.isFooter && !$0.0.isHeader }
        
        // Split header & footer PDFCommands
        let footers = document.objects.filter { return $0.0.isFooter }
        let headers = document.objects.filter { return $0.0.isHeader }
        
        // Only add space between content and footer if footer PDFCommands exist.
        if footers.count == 0 {
            document.layout.space.footer = 0
        }
        
        // Only add space between content and header if header PDFCommands exist.
        if headers.count == 0 {
            document.layout.space.header = 0
        }
        
        // Progress equals the number of PDFCommands run. Each PDFCommand is called once for calculations and second for rendering.
        var progressIndex: CGFloat = 0.0;
        let progressMax: CGFloat = CGFloat(contentObjects.count * 2)
        
        // Only calculate render header & footer metrics if page has content.
        if contentObjects.count > 0 {
            try renderHeaderFooter(calculate: true)
        }
        
        // Dry run all PDFObjects. This won't render anything but instad calculate all the frames.
        for (container, pdfObject) in contentObjects {
            try autoreleasepool {
                try renderPDFObject(container: container, object: pdfObject, calculate: true)
                progressIndex = progressIndex + 1
                progress?(progressIndex / progressMax)
            }
        }
        // Save calculated page count from reseting
        totalPages = currentPage
        
        // Reset all changes made by metrics calculation to generator
        resetGenerator()
        
        // Only render header & footer if page has content.
        if contentObjects.count > 0 {
            try renderHeaderFooter(calculate: false)
        }
        
        // Render each PDFCommand
        for (container, pdfObject) in contentObjects {
            try autoreleasepool {
                try renderPDFObject(container: container, object: pdfObject, calculate: false)
                progressIndex = progressIndex + 1;
                progress?(progressIndex / progressMax)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// MARK: - Command Rendering
    
//    func renderPDFCommand(_ container: PDFContainer, PDFCommand: PDFCommand, calculatingMetrics: Bool) throws {
//        switch PDFCommand {
//        case let .addText(text, spacing):
//            try drawText(container, text: text, spacing: spacing, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addAttributedText(text):
//            try drawAttributedText(container, text: text, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addImage(image, size, caption, sizeFit):
//            try drawImage(container, image: image, size: size, caption: caption, sizeFit: sizeFit, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addImagesInRow(images, captions, spacing):
//            try drawImagesInRow(container, images: images, captions: captions, spacing: spacing, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addLineSeparator(style):
//            drawLineSeparator(container, style: style, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addTable(table):
//            try drawTable(container, cells: table.cells, relativeColumnWidth: table.widths, padding: CGFloat(table.padding), margin: CGFloat(table.margin), style: table.style, showHeadersOnEveryPage: table.showHeadersOnEveryPage, calculatingMetrics: calculatingMetrics)
//            break
//        case let .addList(list):
//            try drawList(container, list: list, calculatingMetrics: calculatingMetrics)
//            break
    
    func renderHeaderFooter(calculate: Bool) throws {
        resetHeaderFooterHeight()
        
        let pagination = document.pagination
        
        if pagination.container != .none {
            if !pagination.hiddenPages.contains(currentPage) && currentPage >= pagination.range.start && currentPage <= pagination.range.end {
                let textObject = PDFTextObject(text: pagination.style.format(page: currentPage, total: totalPages))
                try renderPDFObject(container: pagination.container, object: textObject, calculate: calculate)
            }
        }
        
        for (container, pdfObject) in headerFooterObjects {
            try renderPDFObject(container: container, object: pdfObject, calculate: calculate)
        }
    }
    
    func renderPDFObject(container: PDFContainer, object: PDFObject, calculate: Bool = false) throws {
        if calculate {
            try object.calculate(generator: self, container: container)
        } else {
            try object.calculate(generator: self, container: container)
            try object.draw(generator: self, container: container)
        }
    }
    
}
