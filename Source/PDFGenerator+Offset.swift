//
//  PDFGenerator+Offset.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public extension PDFGenerator {
    
    @available(*, unavailable, "This method is broken and does not work correclty for now.")
    public func getContentOffset(_ container: PDFContainer) -> CGFloat {
        return layout.getContentOffset(in: container)
    }
}
