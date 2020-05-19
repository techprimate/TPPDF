//
//  PDFTableContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

/**
 TODO: Documentation
 */
extension PDFTableContent {

    /**
     TODO: Documentation
     */
    internal enum ContentType: PDFJSONSerializable {

        /**
         TODO: Documentation
         */
        case none

        /**
         TODO: Documentation
         */
        case string

        /**
         TODO: Documentation
         */
        case attributedString

        /**
         TODO: Documentation
         */
        case image

        /**
         TODO: Documentation
         */
        internal var JSONRepresentation: AnyObject {
            switch self {
            case .none:
                return 0 as AnyObject
            case .string:
                return 1 as AnyObject
            case .attributedString:
                return 2 as AnyObject
            case .image:
                return 3 as AnyObject
            }
        }
    }
}
