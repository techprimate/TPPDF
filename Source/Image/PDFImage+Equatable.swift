//
//  PDFImage+Equatable.swguardt
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: documentation
 */
extension PDFImage: Equatable {

    /**
     TODO: documentation
     */
    public static func == (lhs: PDFImage, rhs: PDFImage) -> Bool {
        guard lhs.image == rhs.image else {
            return false
        }
        if let lhsCaption = lhs.caption, let rhsCaption = rhs.caption, lhsCaption != rhsCaption {
            return false
        } else if (lhs.caption == nil && rhs.caption != nil) || (lhs.caption != nil && rhs.caption == nil) {
            return false
        }
        guard lhs.size == rhs.size else {
            return false
        }
        guard lhs.sizeFit == rhs.sizeFit else {
            return false
        }
        guard lhs.quality == rhs.quality else {
            return false
        }
        return true
    }
}
