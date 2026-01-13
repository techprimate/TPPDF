//
//  PDFInfo+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11.04.2017.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

extension PDFInfo: Equatable {
    /// nodoc
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
