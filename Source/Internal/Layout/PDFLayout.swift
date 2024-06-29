//
//  PDFLayout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 Contains all relevant layout informations of a pdf document
 */
class PDFLayout: CustomStringConvertible {
    var heights = PDFLayoutHeights()
    var indentation = PDFLayoutIndentations()
    var margin: EdgeInsets = .zero

    func getContentOffset(in container: PDFContainer) -> CGFloat {
        if container.isHeader {
            return heights.header[container]!
        } else if container.isFooter {
            return heights.footer[container]!
        }
        return heights.content
    }

    func setContentOffset(in container: PDFContainer, to value: CGFloat) {
        if container.isHeader {
            heights.header[container] = value
        } else if container.isFooter {
            heights.footer[container] = value
        } else {
            heights.content = value
        }
    }

    func reset() {
        heights = PDFLayoutHeights()
        indentation = PDFLayoutIndentations()
        margin = .zero
    }
}
