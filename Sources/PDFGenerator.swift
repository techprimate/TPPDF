//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//
//

open class PDFGenerator  {
    
    // MARK: - Public Variables
    
    open var layout: PDFLayout = PDFLayout()
    open var info: PDFInfo = PDFInfo()
    open var pagination: PDFPagination = PDFPagination()
    
    open var imageQuality: CGFloat = 0.8 {
        didSet {
            if imageQuality > 1 {
                imageQuality = 1
            }
        }
    }
    
    // MARK: - Private Variables
    
    var commands: [(PDFContainer, PDFCommand)] = []
    var headerFooterCommands: [(PDFContainer, PDFCommand)] = []
    
    var headerHeight: [PDFContainer : CGFloat] = [:]
    var footerHeight: [PDFContainer : CGFloat] = [:]
    var contentHeight: CGFloat = 0
    
    var contentSize: CGSize {
        return CGSize(
            width: layout.pageBounds.width - 2 * layout.margin.side,
            height: layout.pageBounds.height - maxHeaderHeight() - layout.space.header - maxFooterHeight() - layout.space.footer
        )
    }
    
    var indentation: [PDFContainer: CGFloat] = [
        .headerLeft : 0,
        .contentLeft : 0,
        .footerLeft : 0
    ]
    
    var currentPage: Int = 1
    var totalPages: Int = 0
    
    lazy var fonts: [PDFContainer: UIFont] = {
        var defaults = [PDFContainer: UIFont]()
        for container in PDFContainer.all + [PDFContainer.none] {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()
    
    var textColor: UIColor = UIColor.black
    
    // MARK: - Tools
    
    /**
     Generates PDF data and writes it to a temporary file.
     
     - parameter document:  PDFDocument which should be converted into a PDF file.
     - parameter filename:  Name of temporary file.
     - parameter progress:  Optional closure for progress handling. Parameter is between 0.0 and 1.0
     - returns:             URL to temporary file.
     
     - throws:              PDFError
     */
    public static func generate(_ document: PDFDocument, filename: String, progress: ((CGFloat) -> ())? = nil) throws -> URL {
        let name = filename.hasSuffix(".pdf") ? filename : (filename + ".pdf")
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(name)
        let generator = PDFGenerator()
        
        UIGraphicsBeginPDFContextToFile(url.path, document.layout.pageBounds, document.info.generate())
//        try generator.generatePDFContext(progress: progress)
        UIGraphicsEndPDFContext()
        
        return url;
    }
    
    func generateNewPage(calculatingMetrics: Bool) throws {
        // Don't render if calculating metrics
        if !calculatingMetrics {
            UIGraphicsBeginPDFPageWithInfo(layout.pageBounds, nil)
        }
        contentHeight = 0
        currentPage += 1
        
        try renderHeaderFooter(calculatingMetrics: calculatingMetrics)
    }
    
    func resetGenerator() {
        headerHeight = [:]
        footerHeight = [:]
        contentHeight = 0
        indentation = [
            .headerLeft : 0,
            .contentLeft : 0,
            .footerLeft : 0
        ]
        currentPage = 1
    }
}
