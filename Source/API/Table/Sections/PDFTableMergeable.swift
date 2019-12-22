//
//  PDFTableMergeable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 20.12.19.
//

/**
 Object implementing this protocol should offer the functionality to merge itself into a single value
 */
public protocol PDFTableMergable {

    /**
     Merges all cells by replacing them with the same reference.
     See `merge(with cell:)` for more.
     */
    func merge()

    /**
     Merges all cells by replacing them with the same reference.
     
     If parameter `cell` is given, it will be the value after the merge.
     Otherwise the implementation behaviour is unknown.
     
     - parameter cell: Cell to use after merge, may be nil
     */
    func merge(with cell: PDFTableCell?)
}
