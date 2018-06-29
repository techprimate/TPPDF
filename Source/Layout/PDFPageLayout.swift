//
//  PDFPageLayout.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 Contains all relevant layout informations of a pdf document
 */
public struct PDFPageLayout: PDFJSONSerializable {

    // MARK: - PUBLIC VARS

    /**
     Size of each page
     */
    public var size: CGSize = CGSize.zero

    /**
     Margins of each page.

     `header`: Top inset of page
     `footer`: Bottom inset of page
     `left`: Left inset of page
     `right`: Right inset of page
     */
    public var margin: UIEdgeInsets = .zero

    /**
     Spaces between header, content and footer.

     `header`: Space between header and content
     `footer`: Space between content and footer
     */
    public var space: (header: CGFloat, footer: CGFloat) = (0, 0)

    // MARK: - INTERNAL COMPUTED VARS

    /**
     Returns a `CGRect` with a origin at zero and the `size` of the layout.
     */
    public var bounds: CGRect {
        return CGRect(origin: .zero, size: size)
    }

    /**
     Shorthand access to layout width
     */
    public var width: CGFloat {
        return size.width
    }

    /**
     Shorthand access to layout height
     */
    public var height: CGFloat {
        return size.height
    }

    /**
     Size of content area of each page
     */
    public var contentSize: CGSize {
        return CGSize(
            width: size.width
                - margin.left
                - margin.right,
            height: size.height
                - margin.top
                - space.header
                - space.footer
                - margin.bottom
        )
    }

}
