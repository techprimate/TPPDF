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

    /// nodoc
    public func generateURL(filename: String) throws -> URL {
        return try self.generateURL(filename: filename, info: nil)
    }

    /// nodoc
    public func generate(to url: URL) throws {
        return try self.generate(to: url, info: nil)
    }

    /**
     Generates PDF data and writes it to a temporary file.

     - parameter to:    URL where file should be saved.
     - parameter info:  PDF file information

     - throws:          PDFError
     */
    public func generate(to url: URL, info: PDFInfo?) throws {
        UIGraphicsBeginPDFContextToFile(url.path, document.layout.bounds, (info ?? document.info).generate())
        try generatePDFContext()
        UIGraphicsEndPDFContext()
    }

    /// nodoc
    public func generateData() throws -> Data {
        return try self.generateData(info: nil)
    }

    /**
     Generates PDF data and returns it

     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter info:      Metadata Information added to file

     - returns:             PDF Data

     - throws:              PDFError
     */
    public func generateData(info: PDFInfo?) throws -> Data {
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, document.layout.bounds, (info ?? document.info).generate())
        try generatePDFContext()
        UIGraphicsEndPDFContext()
        return data as Data
    }

    // MARK: - INTERNAL FUNCS

    /**
     Generate PDF Context from PDFCommands

     - throws: PDFError
     */
    public func generatePDFContext() throws {
        let renderObjects = try createRenderObjects()
        try render(objects: renderObjects)
    }

    /**
     Creates a list of container-object pairs which will be rendered.

     - returns: List of renderable objects
     */
    public func createRenderObjects() throws -> [(PDFContainer, PDFRenderObject)] {
        layout.margin = document.layout.margin

        // First calculate master objects
        var masterObjects: [(PDFContainer, PDFRenderObject)] = []
        if let masterGroup = document.masterGroup {
            masterObjects = try masterGroup.calculate(generator: self, container: .contentLeft)
        }
        resetGenerator()

        layout.margin = document.layout.margin

        // Extract content objects
        let contentObjects = PDFGenerator.extractContentObjects(objects: document.objects)
        let numContentObjects = contentObjects.count

        // Extract header & footer objects
        let footers = PDFGenerator.extractFooterObjects(objects: document.objects)
        let headers = PDFGenerator.extractHeaderObjects(objects: document.objects)

        headerFooterObjects = headers + footers

        // Only add space between content and footer if there are objects in footer.
        if footers.isEmpty {
            document.layout.space.footer = 0
        }

        // Only add space between content and header if there are objects in header.
        if headers.isEmpty {
            document.layout.space.header = 0
        }

        var allObjects: [(PDFContainer, PDFRenderObject)] = []

        // Only calculate render header & footer metrics if page has content.
        if numContentObjects > 0 {
            allObjects += try addHeaderFooterObjects()
        }

        var calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Iterate all objects and let them calculate the required rendering
        for (container, pdfObject) in contentObjects {
            if let tocObject = pdfObject as? PDFTableOfContentObject {
                // Create table of content from objects
                tocObject.list = PDFGenerator.createTableOfContentList(objects: contentObjects,
                                                                       styles: tocObject.options.styles,
                                                                       symbol: tocObject.options.symbol)
            }
            let objects = try pdfObject.calculate(generator: self, container: container)
            for obj in objects {
                allObjects.append(obj)

                if let pageObj = obj.1 as? PDFPageBreakObject, !pageObj.stayOnSamePage {
                    currentPage += 1
                    totalPages += 1
                    allObjects += try addHeaderFooterObjects()
                } else if obj.1 is PDFExternalPageObject {
                    currentPage += 1
                    totalPages += 1
                }
            }
            calculationProgress.completedUnitCount += 1
        }

        // Save calculated page count from reseting
        totalPages = currentPage

        // Reset all changes made by metrics calculation to generator
        resetGenerator()
        layout.margin = document.layout.margin

        allObjects = masterObjects

        // Only calculate render header & footer metrics if page has content.
        if !contentObjects.isEmpty {
            allObjects += try addHeaderFooterObjects()
        }

        calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Iterate all objects and let them calculate the required rendering
        for (container, pdfObject) in contentObjects {
            let objects = try pdfObject.calculate(generator: self, container: container)
            for obj in objects {

                allObjects.append(obj)

                if let pageBreak = obj.1 as? PDFPageBreakObject, !pageBreak.stayOnSamePage {
                    allObjects.append(contentsOf: masterObjects)
                }

                if let pageObj = obj.1 as? PDFPageBreakObject, !pageObj.stayOnSamePage {
                    currentPage += 1
                    allObjects += try addHeaderFooterObjects()
                }
            }
            calculationProgress.completedUnitCount += 1
        }
        return allObjects
    }

    /**
     Returns a list of all header and footer objects with their corresponding container.
     This list also contains the pagination object

     - throws: PDFError

     - returns: List of renderable objects
     */
    private func addHeaderFooterObjects() throws -> [(PDFContainer, PDFRenderObject)] {
        var result: [(PDFContainer, PDFRenderObject)] = []

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

    /**
     TODO: Documentation
     */
    private func headerFooterDebugLines() throws -> [(PDFContainer, PDFRenderObject)] {
        let headerFooterDebugLineStyle = PDFLineStyle(type: .dashed, color: .orange, width: 1)

        let yPositions = [
            layout.margin.top + layout.heights.maxHeaderHeight(),
            layout.margin.top + layout.heights.maxHeaderHeight() + document.layout.space.header,
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight(),
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight() - document.layout.space.footer
        ]

        var lines: [PDFLineObject] = []

        for y in yPositions {
            let start = CGPoint(x: 0, y: y)
            let end = CGPoint(x: document.layout.bounds.width, y: y)

            lines.append(PDFLineObject(style: headerFooterDebugLineStyle, startPoint: start, endPoint: end))
        }

        var result: [(PDFContainer, PDFRenderObject)] = []
        for line in lines {
            result += try line.calculate(generator: self, container: .contentLeft)
        }

        return result
    }

    /**
     Renders a list of objects in their corresponding container

     - throws: PDFError, if rendering fails
     */
    internal func render(objects: [(PDFContainer, PDFRenderObject)]) throws {
        UIGraphicsBeginPDFPageWithInfo(document.layout.bounds, nil)

        drawDebugPageOverlay()

        let renderProgress = Progress.discreteProgress(totalUnitCount: Int64(objects.count))
        progress.addChild(renderProgress, withPendingUnitCount: 1)

        for (container, object) in objects {
            try render(object: object, in: container)
            renderProgress.completedUnitCount += 1
        }
    }

    /**
     Render a object in its corresponding container

     - throws: PDFError, if rendering fails
     */
    internal func render(object: PDFRenderObject, in container: PDFContainer) throws {
        try object.draw(generator: self, container: container)
    }

    // MARK: - INTERNAL STATIC FUNCS

    /**
     Filters out all objects which are in the header area

     - parameter objects: List objects

     - returns: List of all header objects
     */
    internal static func extractHeaderObjects(objects: [(PDFContainer, PDFRenderObject)]) -> [(PDFContainer, PDFRenderObject)] {
        return objects.filter { $0.0.isHeader }
    }

    /**
     Filters out all objects which are in the footer area

     - parameter objects: List objects

     - returns: List of all footer objects
     */
    internal static func extractFooterObjects(objects: [(PDFContainer, PDFRenderObject)]) -> [(PDFContainer, PDFRenderObject)] {
        return objects.filter { $0.0.isFooter }
    }

    /**
     Filters out all objects which are in the content area

     - parameter objects: List objects

     - returns: List of all content objects
     */
    internal static func extractContentObjects(objects: [(PDFContainer, PDFRenderObject)]) -> [(PDFContainer, PDFRenderObject)] {
        return objects.filter { !$0.0.isFooter && !$0.0.isHeader }
    }

    /**
     TODO: Documentation
     */
    internal static func createTableOfContentList(objects: [(PDFContainer, PDFRenderObject)],
                                                  styles: [WeakPDFTextStyleRef],
                                                  symbol: PDFListItemSymbol) -> PDFList {
        var elements: [(Int, PDFAttributedTextObject)] = []
        for (_, obj) in objects {
            if let textObj = obj as? PDFAttributedTextObject,
                let style = textObj.simpleText?.style,
                let styleIndex = styles.firstIndex(where: { $0.value === style }) {
                elements.append((styleIndex, textObj))
            }
        }
        let list = PDFList(indentations: styles.enumerated().map { (pre: CGFloat($0.offset + 1) * 10, past: 10) })
        var stack = Stack<PDFListItem>()
        for (index, element) in elements {
            let item = PDFListItem(symbol: symbol, content: element.simpleText?.text)

            stack.pop(to: index)
            if index == 0 {
                list.addItem(item)
                stack.push(item)
            } else if let parent = stack.peek(at: index - 1) {
                parent.addItem(item)
                stack.push(item)
            } else {
                for i in stack.count..<index {
                    let placeholderItem = PDFListItem(symbol: .none, content: nil)
                    stack.push(placeholderItem)
                    stack.peek(at: i - 1)?.addItem(placeholderItem)
                }
                stack.peek(at: index - 1)?.addItem(item)
                stack.push(item)
            }
        }
        return list
    }
}
