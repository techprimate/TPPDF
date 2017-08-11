//
//  PDFGenerator+Initialization.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    public convenience init(pageSize: CGSize, pageMargin: CGFloat = 36.0, headerMargin: CGFloat = 20.0, footerMargin: CGFloat = 20.0, headerSpace: CGFloat = 8, footerSpace: CGFloat = 8, paginationContainer: PDFContainer = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        self.init()
        
        self.layout.pageBounds = CGRect(origin: CGPoint.zero, size: pageSize)
        self.layout.pageMargin = pageMargin
        
        self.layout.footerMargin = footerMargin
        self.layout.headerMargin = headerMargin
        
        self.layout.headerSpace = headerSpace
        self.layout.footerSpace = footerSpace
        
        self.pagination.container = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
    
    public convenience init(format: PDFPageFormat, paginationContainer: PDFContainer = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        self.init()
        
        self.layout.pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        self.layout.pageMargin = format.margin
        
        self.layout.footerMargin = format.footerMargin
        self.layout.headerMargin = format.headerMargin
        
        self.layout.headerSpace = format.headerSpace
        self.layout.footerSpace = format.footerSpace
        
        self.pagination.container = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
}
