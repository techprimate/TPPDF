//
//  PDFGenerator+Debug.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24/08/2017.
//

/**
 Adds UI debugging information while rendering.
 */
extension PDFGenerator {

    // MARK: - INTERNAL FUNCS

    /**
     Overlays horizontal and vertical lines at margin insets
     */
    func drawDebugPageOverlay() {
        // Only render if debugging is enabled
        guard debug else {
            return
        }

        // Draw vertical lines at left and right margin inset
        drawVerticalMarginLines(positionX: document.layout.margin.left)
        drawVerticalMarginLines(positionX: document.layout.width - document.layout.margin.right)

        // Draw horizontal lines at top and bottom margin inset
        drawHorizontalMarginLines(positionY: document.layout.margin.top)
        drawHorizontalMarginLines(positionY: document.layout.height - document.layout.margin.bottom)
    }

    // MARK: - PRIVATE COMPUTED VARS

    /**
     Style of debug lines
     */
    private var debugLineStyle: PDFLineStyle {
        return PDFLineStyle(type: .dashed, color: UIColor.blue, width: 1.0)
    }

    // MARK: - PRIVATE FUNCS

    /**
     Draws a horizontal line over the whole page at the given vertical position

     - parameter positionY: Position in points, from top page edge
     */
    private func drawHorizontalMarginLines(positionY: CGFloat) {
        PDFGraphics.drawLine(start: CGPoint(x: 0, y: positionY), end: CGPoint(x: document.layout.width, y: positionY), style: debugLineStyle)
    }

    /**
     Draws a vertical line over the whole page at the given horizontal position

     - parameter positionX: Position in points, from left page edge
     */
    private func drawVerticalMarginLines(positionX: CGFloat) {
        PDFGraphics.drawLine(start: CGPoint(x: positionX, y: 0), end: CGPoint(x: positionX, y: document.layout.height), style: debugLineStyle)
    }

}
