//
//  PDFInfo+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

/**
 Extends `PDFInfo` with comparison methods
 */
extension PDFInfo: Equatable {

    /**
     Compares two instances of `PDFInfo` for equality

     - parameter lhs: Left side object
     - parameter rhs: Right side object

     - returns: `true` if all values of `lhs` equals `rhs`
     */
    public static func == (lhs: PDFInfo, rhs: PDFInfo) -> Bool {
        return lhs.title == rhs.title
            && lhs.author == rhs.author
            && lhs.subject == rhs.subject
            && lhs.keywords == rhs.keywords
            && lhs.ownerPassword == rhs.ownerPassword
            && lhs.userPassword == rhs.userPassword
            && lhs.allowsPrinting == rhs.allowsPrinting
            && lhs.allowsCopying == rhs.allowsCopying
    }

}
