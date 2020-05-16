//
//  PDFTableContentable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.05.20.
//

/**
 Adds functionality to convert to a PDF table content
 */
public protocol PDFTableContentable {

    /**
     - returns: `PDFTableContent` with correct type and holding data
     */
    var asTableContent: PDFTableContent { get }

}
