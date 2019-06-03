//
//  PDFTableOfContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

import Foundation

typealias WeakPDFTextStyleRef = WeakRef<PDFTextStyle>

public class PDFTableOfContent: PDFJSONSerializable {

    internal var styles: [WeakPDFTextStyleRef]

    public var symbol: PDFListItemSymbol

    public init(styles: [PDFTextStyle], symbol: PDFListItemSymbol) {
        self.styles = styles.map { WeakPDFTextStyleRef(value: $0) }
        self.symbol = symbol
    }

    var copy: PDFTableOfContent {
        let object = PDFTableOfContent(styles: [], symbol: symbol)
        object.styles = self.styles.map { $0 }
        return object
    }

}
