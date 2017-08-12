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
            heights.header[container] = value
        } else if container.isFooter {
            heights.footer[container] = value
        } else {
            heights.content = value
        }
    }
    
    func getContentOffset(_ container: PDFContainer) -> CGFloat {
        switch container.normalize {
        case .headerLeft:
            return heights.header[container]!
        case .contentLeft:
            return heights.content
        case .footerLeft:
            return heights.footer[container]!
        default:
            return 0
        }
    }
}
