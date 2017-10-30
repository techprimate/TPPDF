//
//  PDFLayoutIndentations.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30/10/2017.
//

/**
 Holds indentations of header, content and footer.
 */
struct PDFLayoutIndentations {

    /**
     Left and right indentation of header containers
     */
    var header: (left: CGFloat, right: CGFloat) = (0, 0)
    
    /**
     Left and right indentation of content containers
     */
    var content: (left: CGFloat, right: CGFloat) = (0, 0)
    
    /**
     Left and right indentation of footer containers
     */
    var footer: (left: CGFloat, right: CGFloat) = (0, 0)
    
    // MARK: - INTERNAL FUNCS
    
    /**
     The given container is normalized and then returns the left indentation from either header, content or footer.
     
     - parameter container: Container whose left indentation is requested
     
     - returns: Left indentation of given container
     */
    func leftIn(container: PDFContainer) -> CGFloat {
        switch container.normalize {
        case .headerLeft:
            return header.left
        case .contentLeft:
            return content.left
        case .footerLeft:
            return footer.left
        default:
            return 0
        }
    }
    
    /**
     The given container is normalized and then returns the right indentation from either header, content or footer.
     
     - parameter container: Container whose right indentation is requested
     
     - returns: Right indentation of given container
     */
    func rightIn(container: PDFContainer) -> CGFloat {
        switch container.normalize {
        case .headerLeft:
            return header.right
        case .contentLeft:
            return content.right
        case .footerLeft:
            return footer.right
        default:
            return 0
        }
    }
    
    /**
     Sets the given `indentation` as the left indentation in the normalized container `container`.
     
     - parameter indentation: Distance of points
     - parameter container: Corresponding container
     */
    mutating func setLeft(indentation: CGFloat, in container: PDFContainer) {
        switch container.normalize {
        case .headerLeft:
            header.left = indentation
        case .contentLeft:
            content.left = indentation
        case .footerLeft:
            footer.left = indentation
        default:
            break
        }
    }
    
    /**
     Sets the given `indentation` as the right indentation in the normalized container `container`.
     
     - parameter indentation: Distance of points
     - parameter container: Corresponding container
     */
    mutating func setRight(indentation: CGFloat, in container: PDFContainer) {
        switch container.normalize {
        case .headerLeft:
            header.right = indentation
        case .contentLeft:
            content.right = indentation
        case .footerLeft:
            footer.right = indentation
        default:
            break
        }
    }
}
