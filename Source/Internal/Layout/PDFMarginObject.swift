//
//  PDFMarginObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 TODO: Documentation
 */
class PDFMarginObject: PDFRenderObject {
    /**
     TODO: Documentation
     */
    var values: (left: CGFloat?, right: CGFloat?, top: CGFloat?, bottom: CGFloat?)

    /**
     TODO: Documentation
     */
    var reset: Bool

    /**
     TODO: Documentation
     */
    convenience init(reset: Bool) {
        self.init(left: nil, right: nil, top: nil, bottom: nil, reset: reset)
    }

    /**
     TODO: Documentation
     */
    convenience init(left: CGFloat? = nil, right: CGFloat? = nil, top: CGFloat? = nil, bottom: CGFloat? = nil) {
        self.init(left: left, right: right, top: top, bottom: bottom, reset: false)
    }

    /**
     TODO: Documentation
     */
    init(left: CGFloat?, right: CGFloat?, top: CGFloat?, bottom: CGFloat?, reset: Bool) {
        self.values = (left, right, top, bottom)
        self.reset = reset
    }

    /**
     TODO: Documentation
     */
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        if reset {
            generator.layout.margin = generator.document.layout.margin
            return [(container, self)]
        }

        if let left = values.left {
            generator.layout.margin.left = left
        }
        if let right = values.right {
            generator.layout.margin.right = right
        }
        if let top = values.top {
            generator.layout.margin.top = top
        }
        if let bottom = values.bottom {
            generator.layout.margin.bottom = bottom
        }
        return [(container, self)]
    }

    /**
     TODO: Documentation
     */
    override var copy: PDFRenderObject {
        PDFMarginObject(left: values.left,
                        right: values.right,
                        top: values.top,
                        bottom: values.bottom,
                        reset: reset)
    }
}
