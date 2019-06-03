//
//  PDFTableOfContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

/**
 TODO: Documentation
 */
typealias WeakPDFTextStyleRef = WeakRef<PDFTextStyle>

/**
 TODO: Documentation
 */
public class PDFTableOfContent: PDFJSONSerializable {

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
        self.styles = styles.map { WeakPDFTextStyleRef(value: $0) }
        self.symbol = symbol
    }

    /**
     TODO: Documentation
     */
    var copy: PDFTableOfContent {
        let object = PDFTableOfContent(styles: [], symbol: symbol)
        object.styles = self.styles.map { $0 }
        return object
    }
}
