//
//  PDFLayout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public struct PDFLayout: TPJSONSerializable {
    
    public var size: CGSize = CGSize.zero
    public var margin: (header: CGFloat, footer: CGFloat, side: CGFloat) = (0, 0, 0)
    public var space: (header: CGFloat, footer: CGFloat) = (0, 0)
    
    public var pageBounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }

}
