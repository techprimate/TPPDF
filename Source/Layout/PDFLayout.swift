//
//  PDFLayout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31/10/2017.
//

/**
 Contains all relevant layout informations of a pdf document
 */
class PDFLayout: TPJSONSerializable {
    
    var heights = PDFLayoutHeights()
    var indentation = PDFLayoutIndentations()
    
    // MARK: - INTERNAL FUNCS
    
    func reset() {
        heights = PDFLayoutHeights()
        indentation = PDFLayoutIndentations()
    }
}
