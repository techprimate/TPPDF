//
//  PDFTableOfContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

/**
 Type alias for weak references to document wide text styles
 */
internal typealias WeakPDFTextStyleRef = WeakRef<PDFTextStyle>

/**
 TODO: Documentation
 */
public class PDFTableOfContent: PDFDocumentObject {

    /**
     TODO: Documentation
     */
    internal var styles: [WeakPDFTextStyleRef]

    /**
     TODO: Documentation
     */
    public var symbol: PDFListItemSymbol

    /**
     TODO: Documentation
     */
    public init(styles: [PDFTextStyle], symbol: PDFListItemSymbol) {
        self.styles = styles.map(WeakPDFTextStyleRef.init(value:))
        self.symbol = symbol
    }

    /**
     TODO: Documentation
     */
    internal var copy: PDFTableOfContent {
        let object = PDFTableOfContent(styles: [], symbol: symbol)
        object.styles = Array(styles)
        return object
    }
}
