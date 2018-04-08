//
//  PDFGenerator+Layout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 Extends the generator with shorthand methods for accessing and modifying the layout
 */
extension PDFGenerator {

    /**
     Get content offset of the given `container`

     - parameter container: Container where the offset is requested

     - returns: Offset in points
     */
    func getContentOffset(in container: PDFContainer) -> CGFloat {
        return layout.getContentOffset(in: container)
    }

    /**
     Set a content offset to a value of a given container

     - parameter container: Container where the offset is set
     - parameter value: Offset value
     */
    func setContentOffset(in container: PDFContainer, to value: CGFloat) {
        layout.setContentOffset(in: container, to: value)
    }

}
