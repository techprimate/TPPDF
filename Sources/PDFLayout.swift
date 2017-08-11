//
//  PDFLayout.swift
//  Pods
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

public struct PDFLayout {
    
    public var pageBounds: CGRect
    public var pageMargin: CGFloat
    
    public var headerMargin: CGFloat
    public var footerMargin: CGFloat
    
    public var headerSpace: CGFloat
    public var footerSpace: CGFloat
    
    public init(pageBounds: CGRect = .zero, pageMargin: CGFloat = 0, headerMargin: CGFloat = 0, footerMargin: CGFloat = 0, headerSpace: CGFloat = 0, footerSpace: CGFloat = 0) {
        self.pageBounds = pageBounds
        self.pageMargin = pageMargin
        
        self.headerMargin = headerMargin
        self.footerMargin = footerMargin
        
        self.headerSpace = headerSpace
        self.footerSpace = footerSpace
    }
}
