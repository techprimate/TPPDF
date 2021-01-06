//
//  PDFGenerator+Debug.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24/08/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 Adds UI debugging information while rendering.
 */
extension PDFGenerator {

    // MARK: - INTERNAL FUNCSs

    /**
     Overlays horizontal and vertical lines at margin insets
     */
    internal func drawDebugPageOverlay(in context: PDFContext) {
        // Only render if debugging is enabled
        guard debug else {
            return
        }

        // Draw vertical lines at left and right margin inset
        drawVerticalMarginLines(in: context, positionX: layout.margin.left)
        drawVerticalMarginLines(in: context, positionX: document.layout.width - layout.margin.right)

        // Draw horizontal lines at top and bottom margin inset
        drawHorizontalMarginLines(in: context, positionY: layout.margin.top)
        drawHorizontalMarginLines(in: context, positionY: document.layout.height - layout.margin.bottom)
    }

    // MARK: - PRIVATE COMPUTED VARS

    /**
     Style of debug lines
     */
    private var debugLineStyle: PDFLineStyle {
        PDFLineStyle(type: .dashed, color: Color.blue, width: 1.0)
    }

    // MARK: - PRIVATE FUNCS

    /**
     Draws a horizontal line over the whole page at the given vertical position

     - parameter positionY: Position in points, from top page edge
     */
    private func drawHorizontalMarginLines(in context: PDFContext, positionY: CGFloat) {
        PDFGraphics.drawLine(in: context, start: CGPoint(x: 0, y: positionY), end: CGPoint(x: document.layout.width, y: positionY), style: debugLineStyle)
    }

    /**
     Draws a vertical line over the whole page at the given horizontal position

     - parameter positionX: Position in points, from left page edge
     */
    private func drawVerticalMarginLines(in context: PDFContext, positionX: CGFloat) {
        PDFGraphics.drawLine(in: context, start: CGPoint(x: positionX, y: 0), end: CGPoint(x: positionX, y: document.layout.height), style: debugLineStyle)
    }

}
