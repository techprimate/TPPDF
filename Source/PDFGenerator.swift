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
    
    var leftOverContentSize: CGSize {
        return CGSize(
            width: document.layout.contentSize.width
                - indentation.content.left
                - indentation.content.right,
            height: document.layout.contentSize.height
                - maxHeaderHeight()
                - maxFooterHeight()
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
    
    func resetGenerator() {
        heights = PDFLayoutHeights()
        indentation = PDFLayoutIndentations()
        currentPage = 1
        textColor = .black
    }
}
