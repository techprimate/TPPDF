//
//  PDFInfo+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04/11/2017.
//

extension PDFInfo: Equatable {

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
