//
//  PDFGenerator+Generation.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//

/**
 Gives the generator the functionality to convert a `PDFDocument` into a `PDF`
 */
extension PDFGenerator {

    // MARK: - PUBLIC STATIC FUNCS

    /**
     Generates PDF data and writes it to a temporary file.

     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter filename:  Name of temporary file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - parameter debug:     Enables debugging

     - returns:             URL to temporary file.

     - throws:              PDFError
     */
    public static func generateURL(document: PDFDocument, filename: String, progress: ((CGFloat) -> Void)? = nil, debug: Bool = false) throws -> URL {
        let name = filename.lowercased().hasSuffix(".pdf") ? filename : (filename + ".pdf")
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        let generator = PDFGenerator(document: document)

        generator.progressValue = 0
        generator.debug = debug

        UIGraphicsBeginPDFContextToFile(url.path, document.layout.bounds, document.info.generate())
        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()

        return url
    }

    /**
     Generates PDF data and writes it to a temporary file.

     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter to url:    URL where file should be saved.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - parameter debug:     Enables debugging

     - returns:             URL to temporary file.

     - throws:              PDFError
     */
    public static func generate(document: PDFDocument, to url: URL, progress: ((CGFloat) -> Void)? = nil, debug: Bool = false) throws {
        let generator = PDFGenerator(document: document)

        generator.progressValue = 0
        generator.debug = debug

        UIGraphicsBeginPDFContextToFile(url.path, document.layout.bounds, document.info.generate())
        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
    }

    /**
     Generates PDF data and returns it

     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - parameter debug:     Enables debugging

     - returns:             PDF Data

     - throws:              PDFError

     */
    public static func generateData(document: PDFDocument, progress: ((CGFloat) -> Void)? = nil, debug: Bool = false) throws -> Data {
        let data = NSMutableData()
        let generator = PDFGenerator(document: document)

        generator.progressValue = 0
        generator.debug = debug

        UIGraphicsBeginPDFContextToData(data, document.layout.bounds, document.info.generate())
        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()

        return data as Data
    }

    // MARK: - INTERNAL FUNCS

    /**
     Generate PDF Context from PDFCommands

     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0

     - throws: PDFError
     */
    func generatePDFContext(progress: ((CGFloat) -> Void)?) throws {
        progress?(progressValue)
        let renderObjects = try createRenderObjects(progress: progress)
        try render(objects: renderObjects, progress: progress)
        progress?(progressValue)
    }

    /**
     Creates a list of container-object pairs which will be rendered.

     - returns: List of renderable objects
     */
    func createRenderObjects(progress: ((CGFloat) -> Void)?) throws -> [(PDFContainer, PDFObject)] {
        // Extract content objects
        let contentObjects = PDFGenerator.extractContentObjects(objects: document.objects)
        let numContentObjects = contentObjects.count

        // Extract header & footer objects
        let footers = PDFGenerator.extractFooterObjects(objects: document.objects)
        let headers = PDFGenerator.extractHeaderObjects(objects: document.objects)

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
        if numContentObjects > 0 {
            allObjects += try addHeaderFooterObjects()
        }

        // Iterate all objects and let them calculate the required rendering
        for (container, pdfObject) in contentObjects {
            let objects = try pdfObject.calculate(generator: self, container: container)
            for obj in objects {
                allObjects.append(obj)

                if obj.1 is PDFPageBreakObject {
                    currentPage += 1
                    totalPages += 1
                    allObjects += try addHeaderFooterObjects()
                }
            }
            progressValue += 0.5 / CGFloat(2 * numContentObjects)
            progress?(progressValue)
        }

        // Save calculated page count from reseting
        totalPages = currentPage

        // Reset all changes made by metrics calculation to generator
        resetGenerator()
        allObjects = []

        // Only calculate render header & footer metrics if page has content.
        if contentObjects.count > 0 {
            allObjects += try addHeaderFooterObjects()
        }

        // Iterate all objects and let them calculate the required rendering
        for (container, pdfObject) in contentObjects {
            let objects = try pdfObject.calculate(generator: self, container: container)
            for obj in objects {
                allObjects.append(obj)

                if obj.1 is PDFPageBreakObject {
                    currentPage += 1
                    allObjects += try addHeaderFooterObjects()
                }
            }
            progressValue += 0.5 / CGFloat(2 * numContentObjects)
            progress?(progressValue)
        }
        return allObjects
    }

    /**
     Returns a list of all header and footer objects with their corresponding container.
     This list also contains the pagination object

     - throws: PDFError

     - returns: List of renderable objects
     */
    func addHeaderFooterObjects() throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        layout.heights.resetHeaderFooterHeight()

        let pagination = document.pagination

        if pagination.container != .none {
            if !pagination.hiddenPages.contains(currentPage) && currentPage >= pagination.range.start && currentPage <= pagination.range.end {
                let text = pagination.style.format(page: currentPage, total: totalPages)
                let attributedText = NSAttributedString(string: text, attributes: pagination.textAttributes)
                let textObject = PDFAttributedTextObject(attributedText: PDFAttributedText(text: attributedText))
                result += try textObject.calculate(generator: self, container: pagination.container)
            }
        }
        for (container, headerFooter) in headerFooterObjects {
            result += try headerFooter.copy.calculate(generator: self, container: container)
        }

        if debug {
            result += try headerFooterDebugLines()
        }

        return result
    }

    private func headerFooterDebugLines() throws -> [(PDFContainer, PDFObject)] {
        let headerFooterDebugLineStyle = PDFLineStyle(type: .dashed, color: .orange, width: 1)

        let yPositions = [
            document.layout.margin.top + layout.heights.maxHeaderHeight(),
            document.layout.margin.top + layout.heights.maxHeaderHeight() + document.layout.space.header,
            document.layout.height - document.layout.margin.bottom - layout.heights.maxFooterHeight(),
            document.layout.height - document.layout.margin.bottom - layout.heights.maxFooterHeight() - document.layout.space.footer
        ]

        var lines: [PDFLineObject] = []

        for y in yPositions {
            let start = CGPoint(x: 0, y: y)
            let end = CGPoint(x: document.layout.bounds.width, y: y)

            lines.append(PDFLineObject(style: headerFooterDebugLineStyle, startPoint: start, endPoint: end))
        }

        var result: [(PDFContainer, PDFObject)] = []
        for line in lines {
            result += try line.calculate(generator: self, container: .contentLeft)
        }

        return result
    }

    /**
     Renders a list of objects in their corresponding container

     - throws: PDFError, if rendering fails
     */
    func render(objects: [(PDFContainer, PDFObject)], progress: ((CGFloat) -> Void)?) throws {
        UIGraphicsBeginPDFPageWithInfo(document.layout.bounds, nil)

        drawDebugPageOverlay()

        let numObjects = objects.count
        for (container, object) in objects {
            try render(object: object, in: container)
            progressValue += 0.5 / CGFloat(numObjects)
            progress?(progressValue)
        }
    }

    /**
     Render a object in its corresponding container

     - throws: PDFError, if rendering fails
     */
    func render(object: PDFObject, in container: PDFContainer) throws {
        try object.draw(generator: self, container: container)
    }

    // MARK: - INTERNAL STATIC FUNCS

    /**
     Filters out all objects which are in the header area

     - parameter objects: List objects

     - returns: List of all header objects
     */
    static func extractHeaderObjects(objects: [(PDFContainer, PDFObject)]) -> [(PDFContainer, PDFObject)] {
        return objects.filter { return $0.0.isHeader }
    }

    /**
     Filters out all objects which are in the footer area

     - parameter objects: List objects

     - returns: List of all footer objects
     */
    static func extractFooterObjects(objects: [(PDFContainer, PDFObject)]) -> [(PDFContainer, PDFObject)] {
        return objects.filter { return $0.0.isFooter }
    }

    /**
     Filters out all objects which are in the content area

     - parameter objects: List objects

     - returns: List of all content objects
     */
    static func extractContentObjects(objects: [(PDFContainer, PDFObject)]) -> [(PDFContainer, PDFObject)] {
        return objects.filter { return !$0.0.isFooter && !$0.0.isHeader }
    }

}
