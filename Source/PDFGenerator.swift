//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//
//

public class PDFGenerator {
    
    // MARK: - PUBLIC STATIC VARS
    
    public static var debug: Bool = false
    
    // MARK: - INTERNAL VARS
    
    var document: PDFDocument
    var headerFooterObjects: [(PDFContainer, PDFObject)] = []
    
    var heights = PDFLayoutHeights()
    var indentation = PDFLayoutIndentations()
    
    var currentPage: Int = 1
    var totalPages: Int = 0
    
    var textColor: UIColor = UIColor.black
    
    // MARK: - INTERNAL COMPUTED VARS
    
    var contentSize: CGSize {
        return CGSize(
            width: document.layout.width
                - document.layout.margin.left
                - document.layout.margin.right,
            height: document.layout.height
                - maxHeaderHeight()
                - document.layout.space.header
                - maxFooterHeight()
                - document.layout.space.footer
        )
    }
    
    lazy var fonts: [PDFContainer: UIFont] = {
        var defaults = [PDFContainer: UIFont]()
        for container in PDFContainer.all + [PDFContainer.none] {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()
    
    // MARK: - INTERNAL INITS
    
    init(document: PDFDocument) {
        self.document = document
        
        resetHeaderFooterHeight()
    }
    
    // MARK: - INTERNAL FUNCS
    
    func generateNewPage(calculatingMetrics: Bool) throws {
        // Don't render if calculating metrics
        if !calculatingMetrics {
            UIGraphicsBeginPDFPageWithInfo(document.layout.bounds, nil)
            drawDebugPageOverlay()
        }
        heights.content = 0
        currentPage += 1
        
        try renderHeaderFooter(calculate: calculatingMetrics)
    }
    
    func resetGenerator() {
        heights = PDFLayoutHeights()
        indentation = PDFLayoutIndentations()
        currentPage = 1
        textColor = .black
    }
}
