//
//  PDFLayoutHeights.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30/10/2017.
//

/**
 TODO: documentation
 */
internal struct PDFLayoutHeights: CustomStringConvertible {

    /**
     TODO: documentation
     */
    internal var header: [PDFContainer: CGFloat] = [:]

    /**
     TODO: documentation
     */
    internal var footer: [PDFContainer: CGFloat] = [:]

    /**
     TODO: documentation
     */
    internal var content: CGFloat = 0

    /**
     TODO: documentation
     */
    internal init() {
        resetHeaderFooterHeight()
    }

    /**
     TODO: documentation
     */
    internal mutating func resetHeaderFooterHeight() {
        header[.headerLeft] = 0
        header[.headerCenter] = 0
        header[.headerRight] = 0

        footer[.footerLeft] = 0
        footer[.footerCenter] = 0
        footer[.footerRight] = 0
    }

    /**
     TODO: documentation
     */
    internal mutating func add(_ value: CGFloat, to container: PDFContainer) {
        if container.isHeader {
            header[container] = (header[container] ?? 0) + value
        } else if container.isFooter {
            footer[container] = (footer[container] ?? 0) + value
        } else {
            content += value
        }
    }

    /**
     TODO: documentation
     */
    internal func maxHeaderHeight() -> CGFloat {
        return header.values.max() ?? 0
    }

    /**
     TODO: documentation
     */
    internal func maxFooterHeight() -> CGFloat {
        return footer.values.max() ?? 0
    }

    /**
     TODO: documentation
     */
    internal func value(for container: PDFContainer) -> CGFloat {
        if container.isHeader {
            return header[container] ?? 0
        } else if container.isFooter {
            return footer[container] ?? 0
        } else {
            return content
        }
    }

    /**
     TODO: documentation
     */
    internal mutating func set(_ value: CGFloat, to container: PDFContainer) {
        if container.isHeader {
            header[container] = value
        } else if container.isFooter {
            footer[container] = value
        } else {
            content = value
        }
    }
}
