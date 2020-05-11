//
//  PDFTableCell.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
import Foundation
import UIKit
import CoreGraphics

/**
 TODO: Documentation
 */
public class PDFTableCell: PDFDocumentObject, PDFJSONSerializable {

    /**
     TODO: Documentation
     */
    public var content: PDFTableContent?

    /**
     TODO: Documentation
     */
    public var style: PDFTableCellStyle?

    /**
     TODO: Documentation
     */
    public var alignment: PDFTableCellAlignment

    /**
     TODO: Documentation
     */
    public init(content: PDFTableContent? = nil, alignment: PDFTableCellAlignment = .center, style: PDFTableCellStyle? = nil) {
        self.content = content
        self.alignment = alignment
        self.style = style
    }
}
