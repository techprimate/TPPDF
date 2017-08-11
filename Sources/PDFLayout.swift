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
    
    public var margin: (header: CGFloat, footer: CGFloat)
    public var space: (header: CGFloat, footer: CGFloat)
    
    public init(pageBounds: CGRect = .zero, pageMargin: CGFloat = 0, headerMargin: CGFloat = 0, footerMargin: CGFloat = 0, headerSpace: CGFloat = 0, footerSpace: CGFloat = 0) {
        self.pageBounds = pageBounds
        self.pageMargin = pageMargin
        
        self.margin = (headerMargin, footerMargin)
        self.space = (headerSpace, footerSpace)
    }
}
