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
        self.layout.margin.side = pageMargin
        
        self.layout.margin.footer = footerMargin
        self.layout.margin.header = headerMargin
        
        self.layout.space.header = headerSpace
        self.layout.space.footer = footerSpace
        
        self.pagination.container = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
    
    public convenience init(format: PDFPageFormat, paginationContainer: PDFContainer = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        self.init()
        
        self.layout.pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        self.layout.margin.side = format.margin
        
        self.layout.margin.footer = format.footerMargin
        self.layout.margin.header = format.headerMargin
        
        self.layout.space.header = format.headerSpace
        self.layout.space.footer = format.footerSpace
        
        self.pagination.container = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
}
