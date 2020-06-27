//
//  PDFLayoutIndentations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30/10/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Holds indentations of header, content and footer.
 */
internal struct PDFLayoutIndentations: CustomStringConvertible {

    /**
     Left and right indentation of header containers
     */
    internal var header: (left: CGFloat, right: CGFloat) = (0, 0)

    /**
     Left and right indentation of content containers
     */
    internal var content: (left: CGFloat, right: CGFloat) = (0, 0)

    /**
     Left and right indentation of footer containers
     */
    internal var footer: (left: CGFloat, right: CGFloat) = (0, 0)

    // MARK: - INTERNAL FUNCS

    /**
     The given container is normalized and then returns the left indentation from either header, content or footer.

     - parameter container: Container whose left indentation is requested

     - returns: Left indentation of given container
     */
    internal func leftIn(container: PDFContainer) -> CGFloat {
        if container.isHeader {
            return header.left
        } else if container.isFooter {
            return footer.left
        }
        return content.left
    }

    /**
     The given container is normalized and then returns the right indentation from either header, content or footer.

     - parameter container: Container whose right indentation is requested

     - returns: Right indentation of given container
     */
    internal func rightIn(container: PDFContainer) -> CGFloat {
        if container.isHeader {
            return header.right
        } else if container.isFooter {
            return footer.right
        }
        return content.right
    }

    /**
     Sets the given `indentation` as the left indentation in the normalized container `container`.

     - parameter indentation: Distance of points
     - parameter container: Corresponding container
     */
    internal mutating func setLeft(indentation: CGFloat, in container: PDFContainer) {
        if container.isHeader {
            header.left = indentation
        } else if container.isFooter {
            footer.left = indentation
        } else {
            content.left = indentation
        }
    }

    /**
     Sets the given `indentation` as the right indentation in the normalized container `container`.

     - parameter indentation: Distance of points
     - parameter container: Corresponding container
     */
    internal mutating func setRight(indentation: CGFloat, in container: PDFContainer) {
        if container.isHeader {
            header.right = indentation
        } else if container.isFooter {
            footer.right = indentation
        } else {
            content.right = indentation
        }
    }
}
