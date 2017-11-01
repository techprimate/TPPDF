//
//  PDFGenerator+Offset.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

public extension PDFGenerator {
    
    public func getContentOffset(in container: PDFContainer) -> CGFloat {
        return layout.getContentOffset(in: container)
    }

    public func setContentOffset(in container: PDFContainer, to value: CGFloat) {
        layout.setContentOffset(in: container, to: value)
    }
}
