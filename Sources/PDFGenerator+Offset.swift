//
//  PDFGenerator+Offset.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

extension PDFGenerator {
    
    func setContentOffset(_ container: PDFContainer = PDFContainer.contentLeft, value: CGFloat) {
        if container.isHeader {
            headerHeight[container] = value
        } else if container.isFooter {
            footerHeight[container] = value
        } else {
            contentHeight = value
        }
    }
    
    func getContentOffset(_ container: PDFContainer) -> CGFloat {
        switch container.normalize {
        case .headerLeft:
            return headerHeight[container]!
        case .contentLeft:
            return contentHeight
        case .footerLeft:
            return footerHeight[container]!
        default:
            return 0
        }
    }
}
