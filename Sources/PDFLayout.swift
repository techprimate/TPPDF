//
//  PDFLayout.swift
//  Pods
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public struct PDFLayout {
    
    public var pageBounds: CGRect = CGRect.zero
    public var margin: (header: CGFloat, footer: CGFloat, side: CGFloat) = (0, 0, 0)
    public var space: (header: CGFloat, footer: CGFloat) = (0, 0)

}
