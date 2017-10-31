//
//  PDFGenerator+Offset.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

extension PDFGenerator {
    
    func setContentOffset(_ container: PDFContainer = PDFContainer.contentLeft, value: CGFloat) {
        if container.isHeader {
            layout.heights.header[container] = value
        } else if container.isFooter {
            layout.heights.footer[container] = value
        } else {
            layout.heights.content = value
        }
    }
    
    func getContentOffset(_ container: PDFContainer) -> CGFloat {
        switch container.normalize {
        case .headerLeft:
            return layout.heights.header[container]!
        case .contentLeft:
            return layout.heights.content
        case .footerLeft:
            return layout.heights.footer[container]!
        default:
            return 0
        }
    }
}
