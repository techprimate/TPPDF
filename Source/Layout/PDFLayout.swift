//
//  PDFLayout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Contains all relevant layout informations of a pdf document
 */
class PDFLayout: PDFJSONSerializable {

    var heights = PDFLayoutHeights()
    var indentation = PDFLayoutIndentations()

    // MARK: - INTERNAL FUNCS

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
    }

}
