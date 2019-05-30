//
//  PDFTableStyle+Equatable.swguardt
//  TPPDF
//
//  Created by Philip Niedertscheider on 09/11/2017.
//

/**
 TODO: Documentation
 */
extension PDFTableStyle: Equatable {

    /**
     TODO: Documentation
     */
    public static func == (lhs: PDFTableStyle, rhs: PDFTableStyle) -> Bool {
        guard lhs.rowHeaderCount == rhs.rowHeaderCount else {
            return false
        }
        guard lhs.columnHeaderCount == rhs.columnHeaderCount else {
            return false
        }
        guard lhs.footerCount == rhs.footerCount else {
            return false
        }
        guard lhs.outline == rhs.outline else {
            return false
        }
        guard lhs.rowHeaderStyle == rhs.rowHeaderStyle else {
            return false
        }
        guard lhs.columnHeaderStyle == rhs.columnHeaderStyle else {
            return false
        }
        guard lhs.footerStyle == rhs.footerStyle else {
            return false
        }
        guard lhs.contentStyle == rhs.contentStyle else {
            return false
        }
        guard lhs.alternatingContentStyle == rhs.alternatingContentStyle else {
            return false
        }
        return true
    }

}
