//
//  PDFGenerator+Initialization.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    public convenience init(pageSize: CGSize, pageMargin: CGFloat = 36.0, headerMargin: CGFloat = 20.0, footerMargin: CGFloat = 20.0, headerSpace: CGFloat = 8, footerSpace: CGFloat = 8, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        self.init()
        
        self.pageBounds = CGRect(origin: CGPoint.zero, size: pageSize)
        self.pageMargin = pageMargin
        
        self.footerMargin = footerMargin
        self.headerMargin = headerMargin
        
        self.headerSpace = headerSpace
        self.footerSpace = footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
    
    public convenience init(format: PageFormat, paginationContainer: Container = .none, imageQuality: CGFloat = 0.8, info: PDFInfo = PDFInfo()) {
        self.init()
        
        pageBounds = CGRect(origin: CGPoint.zero, size: format.size)
        pageMargin = format.margin
        
        footerMargin = format.footerMargin
        headerMargin = format.headerMargin
        
        headerSpace = format.headerSpace
        footerSpace = format.footerSpace
        
        self.paginationContainer = paginationContainer
        self.imageQuality = imageQuality
        
        self.info = info
        
        resetHeaderFooterHeight()
    }
}
