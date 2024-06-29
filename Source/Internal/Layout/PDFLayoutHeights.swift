//
//  PDFLayoutHeights.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30/10/2017.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

struct PDFLayoutHeights: CustomStringConvertible {
    var header: [PDFContainer: CGFloat] = [:]
    var footer: [PDFContainer: CGFloat] = [:]
    var content: CGFloat = 0

    init() {
        resetHeaderFooterHeight()
    }

    /// Resets all three header and footer containers to be zero
    mutating func resetHeaderFooterHeight() {
        header[.headerLeft] = 0
        header[.headerCenter] = 0
        header[.headerRight] = 0

        footer[.footerLeft] = 0
        footer[.footerCenter] = 0
        footer[.footerRight] = 0
    }

    mutating func add(_ value: CGFloat, to container: PDFContainer) {
        if container.isHeader {
            header[container] = (header[container] ?? 0) + value
        } else if container.isFooter {
            footer[container] = (footer[container] ?? 0) + value
        } else {
            content += value
        }
    }

    /**
     * - Returns: Height of highest header container
     */
    func maxHeaderHeight() -> CGFloat {
        header.values.max() ?? 0
    }

    /**
     * - Returns: Height of highest footer  container
     */
    func maxFooterHeight() -> CGFloat {
        footer.values.max() ?? 0
    }

    func value(for container: PDFContainer) -> CGFloat {
        if container.isHeader {
            return header[container] ?? 0
        } else if container.isFooter {
            return footer[container] ?? 0
        } else {
            return content
        }
    }

    mutating func set(_ value: CGFloat, to container: PDFContainer) {
        if container.isHeader {
            header[container] = value
        } else if container.isFooter {
            footer[container] = value
        } else {
            content = value
        }
    }
}
