//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//
//

typealias PDFGeneratorHeights = (header: [PDFContainer : CGFloat], footer: [PDFContainer : CGFloat], content: CGFloat)

public class PDFGenerator  {
    
    // MARK: - Public Variables
    
    public static var debug: Bool = false
    
    public var imageQuality: CGFloat = 0.8 {
        didSet {
            if imageQuality < 0 || imageQuality > 0 {
                imageQuality = min(1.0, max(0.0, imageQuality))
            }
        }
    }
    
    // MARK: - Private Variables
    
    var document: PDFDocument
    var headerFooterObjects: [(PDFContainer, PDFObject)] = []
    var heights: PDFGeneratorHeights = ([:], [:], 0)
    
    var indentation: [PDFContainer: CGFloat] = [
        .headerLeft : 0,
        .contentLeft : 0,
        .footerLeft : 0
    ]
    
    var currentPage: Int = 1
    var totalPages: Int = 0
    
    var textColor: UIColor = UIColor.black
    
    // MARK: - Computed Variables
    
    var contentSize: CGSize {
        return CGSize(
            width: document.layout.pageBounds.width - 2 * document.layout.margin.side,
            height: document.layout.pageBounds.height - maxHeaderHeight() - document.layout.space.header - maxFooterHeight() - document.layout.space.footer
        )
    }
    
    lazy var fonts: [PDFContainer: UIFont] = {
        var defaults = [PDFContainer: UIFont]()
        for container in PDFContainer.all + [PDFContainer.none] {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()
    
    // MARK: - Initialization
    
    init(document: PDFDocument) {
        self.document = document
        
        resetHeaderFooterHeight()
    }
    
    func generateNewPage(calculatingMetrics: Bool) throws {
        // Don't render if calculating metrics
        if !calculatingMetrics {
            UIGraphicsBeginPDFPageWithInfo(document.layout.pageBounds, nil)
        }
        heights.content = 0
        currentPage += 1
        
        try renderHeaderFooter(calculate: calculatingMetrics)
    }
    
    func resetGenerator() {
        heights = ([:], [:], 0)
        indentation = [
            .headerLeft : 0,
            .contentLeft : 0,
            .footerLeft : 0
        ]
        currentPage = 1
        textColor = .black
    }
}
