//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//
//

import UIKit

open class PDFGenerator  {
    
    // MARK: - Public Variables
    
    open var headerImageHeight: CGFloat = 32
    
    open var pageBounds: CGRect = CGRect.zero
    open var pageMargin: CGFloat = 0
    
    open var headerMargin: CGFloat = 0
    open var footerMargin: CGFloat = 0
    
    open var headerSpace: CGFloat = 0
    open var footerSpace: CGFloat = 0
    
    open var info: PDFInfo = PDFInfo()
    
    open var imageQuality: CGFloat = 0.8 {
        didSet {
            if imageQuality > 1 {
                imageQuality = 1
            }
        }
    }
    
    // MARK: - Private Variables
    
    var commands: [(Container, PDFCommand)] = []
    var headerFooterCommands: [(Container, PDFCommand)] = []
    
    var headerHeight: [Container : CGFloat] = [:]
    var footerHeight: [Container : CGFloat] = [:]
    var contentHeight: CGFloat = 0
    
    var contentSize: CGSize {
        return CGSize(width: pageBounds.width - 2 * pageMargin, height: pageBounds.height - maxHeaderHeight() - headerSpace - maxFooterHeight() - footerSpace)
    }
    
    var indentation: [Container: CGFloat] = [
        .headerLeft : 0,
        .contentLeft : 0,
        .footerLeft : 0
    ]
    
    var currentPage: Int = 1
    var totalPages: Int = 0
    var paginationContainer = Container.none
    var paginationStyle = PDFPaginationStyle.Default
    var paginationStart: Int = 1
    var paginationEnd: Int = Int.max
    var paginationExcludes: [Int] = []
    
    lazy var fonts: [Container: UIFont] = {
        var defaults = [Container: UIFont]()
        for container in Container.all + [Container.none] {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()
    
    var textColor: UIColor = UIColor.black
    
    // MARK: - Tools
    
    func generateNewPage(calculatingMetrics: Bool) throws {
        // Don't render if calculating metrics
        if !calculatingMetrics {
            UIGraphicsBeginPDFPageWithInfo(pageBounds, nil)
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
