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
        guard lhs.title == rhs.title else {
            return false
        }
        guard lhs.author == rhs.author else {
            return false
        }
        guard lhs.subject == rhs.subject else {
            return false
        }
        guard lhs.keywords == rhs.keywords else {
            return false
        }
        guard lhs.ownerPassword == rhs.ownerPassword else {
            return false
        }
        guard lhs.userPassword == rhs.userPassword else {
            return false
        }
        guard lhs.allowsPrinting == rhs.allowsPrinting else {
            return false
        }
        guard lhs.allowsCopying == rhs.allowsCopying else {
            return false
        }
        return true
    }
}
