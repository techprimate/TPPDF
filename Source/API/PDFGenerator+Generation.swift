//
//  PDFGenerator+Generation.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Extends the base structure with multiple ways of generating PDF documents from a ``PDFDocument``.
public extension PDFGenerator {
    // MARK: - PUBLIC FUNCS

    /// Convenience method for ``PDFGenerator/generate(to:info:)`` without `info`
    func generateURL(filename: String) throws -> URL {
        try generateURL(filename: filename, info: nil)
    }

    /// Convenience method for ``PDFGenerator/generate(to:info:)`` without `info`
    func generate(to url: URL) throws {
        try generate(to: url, info: nil)
    }

    /**
     * Generates PDF data and writes it to a temporary file at the given URL `to`.
     *
     * - Parameter to:    URL where file should be saved.
     * - Parameter info:  PDF file information
     *
     * - Throws: ``PDFError`` if the calculations or rendering fails
     */
    func generate(to url: URL, info: PDFInfo?) throws {
        let context = PDFContextGraphics.createPDFContext(url: url, bounds: document.layout.bounds, info: info ?? document.info)
        try generatePDFContext(context: context)
        PDFContextGraphics.closePDFContext(context)
    }

    /// Convenience method for ``PDFGenerator/generateData(info:)`` without defining `info`
    func generateData() throws -> Data {
        try generateData(info: nil)
    }

    /**
     * Generates PDF data and returns it
     *
     * - Parameter info: Metadata Information added to file
     *
     * - Throws: ``PDFError`` if the calculations or rendering fails
     *
     * - Returns: PDF file data
     */
    func generateData(info: PDFInfo?) throws -> Data {
        let (data, context) = PDFContextGraphics.createPDFDataContext(bounds: document.layout.bounds, info: info ?? document.info)
        try generatePDFContext(context: context)
        PDFContextGraphics.closePDFContext(context)
        return data as Data
    }

    /**
     * Generate PDF Context from PDFCommands
     *
     * - Throws: ``PDFError`` if the calculations or rendering fails
     */
    func generatePDFContext(context: PDFContext) throws {
        let renderObjects = try createRenderObjects()
        try render(objects: renderObjects, in: context)
    }

    /**
     * Creates a list of container-object pairs which will be rendered.
     *
     * - Throws: ``PDFError`` if the calculations fail
     *
     * - Returns: List of renderable objects
     */
    func createRenderObjects() throws -> [PDFLocatedRenderObject] {
        layout.margin = document.layout.margin

        // First calculate master objects
        var masterObjects: [PDFLocatedRenderObject] = []
        if let masterGroup = document.masterGroup {
            masterObjects = try masterGroup.calculate(generator: self, container: .contentLeft)
        }
        resetGenerator()

        // Extract content objects
        let contentObjects = PDFGenerator.extractContentObjects(objects: document.objects)

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

        // Progress tracking
        var calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Set layout margin according to document spec
        layout.margin = document.layout.margin

        // Save calculated page count from reseting
        totalPages = try estimateTotalPageCount(of: contentObjects, progress: calculationProgress)

        // Progress tracking
        calculationProgress = Progress.discreteProgress(totalUnitCount: Int64(contentObjects.count))
        progress.addChild(calculationProgress, withPendingUnitCount: 1)

        // Set layout margin according to document spec
        layout.margin = document.layout.margin

        // Calculate the actual elements
        return try calculateRenderObjects(contentObjs: contentObjects, masterObj: masterObjects, progress: calculationProgress)
    }

    /**
     * Estimation algorithm for the total pages in the output document
     *
     * This method is used to calculate an over-estimate of the total page count, to reserve enough space in the layout for the necessary elements
     *
     * - Parameter contentObjects: List of objects with their corresponding location
     * - Parameter progress: ``Foundation.Progress`` to report render and calculation progress
     *
     * - Throws: ``PDFError`` if the calculations fail
     */
    private func estimateTotalPageCount(of contentObjects: [PDFLocatedRenderObject], progress: Progress) throws -> Int {
        // Only calculate render header & footer metrics if page has content.
        if !contentObjects.isEmpty && !(contentObjects.first?.1 is PDFExternalPageObject) {
            _ = try addHeaderFooterObjects()
        }

        var hasAddedHeaderFooterToPage = false

        // Iterate all objects and let them calculate the required rendering bounds
        var needsPageBreak = false
        for (pdfObjectIdx, locatedPdfObject) in contentObjects.enumerated() {
            let (container, pdfObject) = locatedPdfObject
            if let tocObject = pdfObject as? PDFTableOfContentObject {
                // Create table of content from objects
                tocObject.list = PDFGenerator.createTableOfContentList(
                    objects: contentObjects,
                    styles: tocObject.options.styles,
                    symbol: tocObject.options.symbol
                )
            }
            let objects = try pdfObject.calculate(generator: self, container: container)
            var prevObj: PDFLocatedRenderObject?
            for (objIdx, obj) in objects.enumerated() {
                if needsPageBreak {
                    // Skip adding page break between external pages
                    if !(prevObj?.1 is PDFExternalPageObject) && !(obj.1 is PDFExternalPageObject) {
                        needsPageBreak = false
                        _ = try PDFPageBreakObject().calculate(generator: self, container: container)
                        currentPage += 1
                    }
                }

                if obj.1 is PDFExternalPageObject {
                    // Do not add counter if one of the following is true:
                    // - external page is the first element
                    if !(pdfObjectIdx == 0 && objIdx == 0) {
                        currentPage += 1
                    }
                    needsPageBreak = true
                } else {
                    if !hasAddedHeaderFooterToPage {
                        hasAddedHeaderFooterToPage = true
                        _ = try addHeaderFooterObjects()
                    }
                }

                if let pageBreak = obj.1 as? PDFPageBreakObject, !pageBreak.stayOnSamePage {
                    currentPage += 1
                    hasAddedHeaderFooterToPage = false
                }
                prevObj = obj
            }
            progress.completedUnitCount += 1
        }

        let result = currentPage

        // Reset all changes made by metrics calculation to generator
        resetGenerator()

        return result
    }

    /**
     * Calculates the layout of given render objects in `contentObjs`, in addition to the given page master object `masterObj`,
     * and returns a list of objects ready to be rendered.
     *
     * - Parameters:
     *     - contentObjs: List of render objects with their location
     *     - masterObj: List of render objects which should be added to every new page
     *     - progress: ``Foundation.Progress`` to report render and calculation progress
     *
     * - Throws: ``PDFError`` if the calculations fail
     */
    private func calculateRenderObjects( // swiftlint:disable:this cyclomatic_complexity
        contentObjs: [PDFLocatedRenderObject],
        masterObj: [PDFLocatedRenderObject],
        progress: Progress
    ) throws -> [PDFLocatedRenderObject] {
        guard !contentObjs.isEmpty else {
            return []
        }

        var result = [PDFLocatedRenderObject]()

        var hasAddedMasterToPage = false
        var hasAddedHeaderFooterToPage = false

        result += masterObj
        hasAddedMasterToPage = true
        // If the first content object is an external page document, skip headers and footers
        if !(contentObjs.first?.1 is PDFExternalDocumentObject) {
            result += try addHeaderFooterObjects()
        }
        hasAddedHeaderFooterToPage = true

        // Iterate all objects and let them calculate the required rendering
        var needsPageBreak = false
        for (container, pdfObject) in contentObjs {
            let objects = try pdfObject.calculate(generator: self, container: container)
            var prevObj: PDFLocatedRenderObject?
            for obj in objects {
                if needsPageBreak {
                    if !(prevObj?.1 is PDFExternalPageObject), !(obj.1 is PDFExternalPageObject) {
                        needsPageBreak = false
                        result += try PDFPageBreakObject().calculate(generator: self, container: container)
                        currentPage += 1
                    }
                }
                if !(obj.1 is PDFExternalPageObject) {
                    if !hasAddedMasterToPage {
                        hasAddedMasterToPage = true

                        // Add master objects to page
                        result += masterObj
                    }
                    if !hasAddedHeaderFooterToPage {
                        hasAddedHeaderFooterToPage = true

                        // Only calculate render header & footer metrics if page has content.
                        result += try addHeaderFooterObjects()
                    }
                }

                result.append(obj)

                if obj.1 is PDFExternalPageObject {
                    needsPageBreak = true
                }

                if let pageBreak = obj.1 as? PDFPageBreakObject, !pageBreak.stayOnSamePage {
                    currentPage += 1
                    hasAddedHeaderFooterToPage = false
                    hasAddedMasterToPage = false
                }
                prevObj = obj
            }
            progress.completedUnitCount += 1
        }

        return result
    }

    /**
     * Returns a list of all header and footer objects with their corresponding container.
     *
     * This list also contains the pagination object.
     *
     * - Throws: ``PDFError`` if calculations fail
     *
     * - Returns: List of renderable objects with their corresponding location
     */
    private func addHeaderFooterObjects() throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        layout.heights.resetHeaderFooterHeight()

        let pagination = document.pagination

        if pagination.container != .none {
            if !pagination.hiddenPages.contains(currentPage), currentPage >= pagination.range.start, currentPage <= pagination.range.end {
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
     * Creates objects to visually render the borders of the header and footer areas
     *
     * - Throws: ``PDFError`` if the calculation fail
     *
     * - Returns: List of render objects with their corresponding location
     */
    private func headerFooterDebugLines() throws -> [PDFLocatedRenderObject] {
        let headerFooterDebugLineStyle = PDFLineStyle(type: .dashed, color: .orange, width: 1)

        let yPositions = [
            layout.margin.top + layout.heights.maxHeaderHeight(),
            layout.margin.top + layout.heights.maxHeaderHeight() + document.layout.space.header,
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight(),
            document.layout.height - layout.margin.bottom - layout.heights.maxFooterHeight() - document.layout.space.footer,
        ]

        var lines: [PDFLineObject] = []

        for y in yPositions {
            let start = CGPoint(x: 0, y: y)
            let end = CGPoint(x: document.layout.bounds.width, y: y)

            lines.append(PDFLineObject(style: headerFooterDebugLineStyle, startPoint: start, endPoint: end))
        }

        var result: [PDFLocatedRenderObject] = []
        for line in lines {
            result += try line.calculate(generator: self, container: .contentLeft)
        }

        return result
    }

    /**
     * Renders a list of objects in their corresponding container
     *
     * - Throws: ``PDFError`` if the rendering fails
     */
    internal func render(objects: [PDFLocatedRenderObject], in context: PDFContext) throws {
        let renderProgress = Progress.discreteProgress(totalUnitCount: Int64(objects.count))
        progress.addChild(renderProgress, withPendingUnitCount: 1)

        // if first element is an external document, do not create the page
        if objects.first?.1 is PDFExternalPageObject == false {
            PDFContextGraphics.beginPDFPage(in: context, for: document.layout.bounds)
            // if there is a background color set, fill the page with it
            if let color = document.background.color {
                PDFGraphics.drawRect(in: context, rect: document.layout.bounds, outline: .none, fill: color)
            }
            drawDebugPageOverlay(in: context)
        }

        for (container, object) in objects {
            try render(object: object, in: container, in: context)
            renderProgress.completedUnitCount += 1
        }

        PDFContextGraphics.endPDFPage(in: context)
    }

    /**
     * Render a object in its corresponding container
     *
     * If a ``PDFGenerator/delegate`` has been configured, its `willBeginDrawing...` and `didFinishDrawing...` methods will be called for
     * the respective render objects as defined here:
     *
     * - ``PDFImageObject``:
     *     - ``PDFGeneratorImageDelegate/generator(willBeginDrawingImage:with:in:)`` before drawing
     *
     * - Throws: ``PDFError``, if rendering fails
     */
    internal func render(object: PDFRenderObject, in container: PDFContainer, in context: PDFContext) throws {
        if let imageObject = object as? PDFImageObject {
            delegate?.generator(willBeginDrawingImage: imageObject.image, with: context, in: object.frame)
        }
        try object.draw(generator: self, container: container, in: context)
    }

    // MARK: - INTERNAL STATIC FUNCS

    /**
     * Filters out all objects which are in the header area
     *
     * - Parameter objects: List of ``PDFLocatedRenderObject``
     *
     * - Returns: Filtered list of ``PDFLocatedRenderObject``
     */
    internal static func extractHeaderObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { $0.0.isHeader }
    }

    /**
     * Filters out all objects which are in the footer area
     *
     * - Parameter objects: List of ``PDFLocatedRenderObject``
     *
     * - Returns: Filtered list of ``PDFLocatedRenderObject``
     */
    internal static func extractFooterObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { $0.0.isFooter }
    }

    /**
     * Filters out all objects which are in the content area
     *
     * - Parameter objects: List of ``PDFLocatedRenderObject``
     *
     * - Returns: Filtered list of ``PDFLocatedRenderObject``
     */
    internal static func extractContentObjects(objects: [PDFLocatedRenderObject]) -> [PDFLocatedRenderObject] {
        objects.filter { !$0.0.isFooter && !$0.0.isHeader }
    }

    /**
     * Creates a tree of nested ``PDFList`` used to render the table of contents.
     *
     * - Parameters:
     *     - objects: List of render objects used as the basis to create the table of contents
     *     - styles: Weak references to the ``PDFTextStyle``
     *     - symbol: Symbol used for the list items, see ``PDFListItem/symbol``
     *
     * - Note: See documentation of ``PDFTableOfContent`` for details on the usage
     */
    internal static func createTableOfContentList(
        objects: [PDFLocatedRenderObject],
        styles: [WeakPDFTextStyleRef],
        symbol: PDFListItemSymbol
    ) -> PDFList {
        var elements: [(Int, PDFAttributedTextObject)] = []
        for (_, obj) in objects {
            if let textObj = obj as? PDFAttributedTextObject,
               let style = textObj.simpleText?.style,
               let styleIndex = styles.firstIndex(where: { $0.value === style }) {
                elements.append((styleIndex, textObj))
            }
        }
        let list = PDFList(indentations: styles.indices.map { (pre: CGFloat($0 + 1) * 10, past: 10) })
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
