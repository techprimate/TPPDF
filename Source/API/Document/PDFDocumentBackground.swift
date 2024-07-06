#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Document background configuration
public struct PDFDocumentBackground {
    /**
     * Color used to fill the background on every page.
     *
     * Defaults to `nil`, which results in a transparent background
     */
    public var color: Color?
}
