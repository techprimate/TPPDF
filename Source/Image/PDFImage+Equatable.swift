//
//  PDFImage+Equatable.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

extension PDFImage: Equatable {

    public static func == (lhs: PDFImage, rhs: PDFImage) -> Bool {
        if lhs.image != rhs.image {
            return false
        }

        if let lhsCaption = lhs.caption, let rhsCaption = rhs.caption, lhsCaption != rhsCaption {
            return false
        }

        if (lhs.caption == nil && rhs.caption != nil) || (lhs.caption != nil && rhs.caption == nil) {
            return false
        }

        if lhs.size != rhs.size {
            return false
        }

        if lhs.sizeFit != rhs.sizeFit {
            return false
        }

        if lhs.quality != rhs.quality {
            return false
        }

        return true
    }

}
