//
//  PDFGenerator+Calculations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func resetHeaderFooterHeight() {
        let margin = document.layout.margin
        
        heights.header[.headerLeft] = margin.header
        heights.header[.headerCenter] = margin.header
        heights.header[.headerRight] = margin.header
        
        heights.footer[.footerLeft] = margin.footer
        heights.footer[.footerCenter] = margin.footer
        heights.footer[.footerRight] = margin.footer
    }
    
    func maxHeaderHeight() -> CGFloat {
        return heights.header.values.max() ?? 0
    }
    
    func maxFooterHeight() -> CGFloat {
        return heights.footer.values.max() ?? 0
    }
}
