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

    public init(styles: [PDFTextStyle]) {
        self.styles = styles.map { WeakPDFTextStyleRef(value: $0) }
    }

    var copy: PDFTableOfContent {
        let object = PDFTableOfContent(styles: [])
        object.styles = self.styles.map { $0 }
        return object
    }

}
