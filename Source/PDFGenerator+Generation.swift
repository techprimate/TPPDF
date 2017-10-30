//
//  PDFGenerator+Generation.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
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
    public static func generateURL(document: PDFDocument, filename: String, progress: ((CGFloat) -> Void)? = nil) throws -> URL {
        let name = filename.lowercased().hasSuffix(".pdf") ? filename : (filename + ".pdf")
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        let generator = PDFGenerator(document: document)
        
        UIGraphicsBeginPDFContextToFile(url.path, document.layout.bounds, document.info.generate())
        try generator.generatePDFContext()
        UIGraphicsEndPDFContext()
        
        return url
    }
    
    /**
     Generates PDF data and returns it
     
     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - returns:             PDF Data
     
     - throws:              PDFError
     
     */
    public static func generateData(document: PDFDocument, progress: ((CGFloat) -> Void)? = nil) throws -> Data {
        let data = NSMutableData()
        let generator = PDFGenerator(document: document)
        
        UIGraphicsBeginPDFContextToData(data, document.layout.bounds, document.info.generate())
        try generator.generatePDFContext()
        UIGraphicsEndPDFContext()
        
        return data as Data
    }
    
    /**
     Generate PDF Context from PDFCommands
     
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     
     - throws: PDFError
     */
    func generatePDFContext() throws {
        let renderObjects = try createRenderObjects()
        try render(objects: renderObjects)
    }
    
    func createRenderObjects() throws -> [(PDFContainer, PDFObject)] {
        // Extract content PDFCommands
        let contentObjects = extractContentObjects()
        
        // Split header & footer PDFCommands
        let footers = document.objects.filter { return $0.0.isFooter }
        let headers = document.objects.filter { return $0.0.isHeader }
        
        // Extract header & footer PDFCommands
        headerFooterObjects = headers + footers
        
        // Only add space between content and footer if there are objects in footer.
        if footers.count == 0 {
            document.layout.space.footer = 0
        }
        
        // Only add space between content and header if there are objects in header.
        if headers.count == 0 {
            document.layout.space.header = 0
        }
        
        var allObjects: [(PDFContainer, PDFObject)] = []
        
        // Only calculate render header & footer metrics if page has content.
        if contentObjects.count > 0 {
            allObjects += try addHeaderFooterObjects()
        }
        
        // Iterate all objects and let them calculate the required rendering
        for (container, pdfObject) in contentObjects {
            allObjects += try pdfObject.calculate(generator: self, container: container)
        }
        
        // Save calculated page count from reseting
        totalPages = currentPage
        
        // Reset all changes made by metrics calculation to generator
        resetGenerator()
        
        return allObjects
    }
    
    func extractHeaderObjects() -> [(PDFContainer, PDFObject)] {
        return document.objects.filter { return $0.0.isHeader }
    }
    
    func extractFooterObjects() -> [(PDFContainer, PDFObject)] {
        return document.objects.filter { return $0.0.isFooter }
    }
    
    func extractContentObjects() -> [(PDFContainer, PDFObject)] {
        return document.objects.filter { return !$0.0.isFooter && !$0.0.isHeader }
    }
    
    func addHeaderFooterObjects() throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []
        
        resetHeaderFooterHeight()
        
        let pagination = document.pagination
        
        if pagination.container != .none {
            if !pagination.hiddenPages.contains(currentPage) && currentPage >= pagination.range.start && currentPage <= pagination.range.end {
                let textObject = PDFAttributedTextObject(text: pagination.style.format(page: currentPage, total: totalPages))
                result += try textObject.calculate(generator: self, container: pagination.container)
            }
        }
        result += headerFooterObjects
        
        return result
    }
    
    func render(objects: [(PDFContainer, PDFObject)]) throws {
        UIGraphicsBeginPDFPageWithInfo(document.layout.bounds, nil)
        
        drawDebugPageOverlay()
        
        for (container, object) in objects {
            try render(object: object, in: container)
        }
    }
    
    func render(object: PDFObject, in container: PDFContainer) throws {
        try object.draw(generator: self, container: container)
    }
}

