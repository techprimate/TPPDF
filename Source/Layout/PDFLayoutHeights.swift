//
//  PDFLayoutHeights.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30/10/2017.
//

struct PDFLayoutHeights {
    
    var header: [PDFContainer: CGFloat] = [:]
    var footer: [PDFContainer: CGFloat] = [:]
    var content: CGFloat = 0
    
    init() {
        resetHeaderFooterHeight()
    }
    
    mutating func resetHeaderFooterHeight() {
        header[.headerLeft] = 0
        header[.headerCenter] = 0
        header[.headerRight] = 0
        
        footer[.footerLeft] = 0
        footer[.footerCenter] = 0
        footer[.footerRight] = 0
    }
    
    func maxHeaderHeight() -> CGFloat {
        return header.values.max() ?? 0
    }
    
    func maxFooterHeight() -> CGFloat {
        return footer.values.max() ?? 0
    }
}
