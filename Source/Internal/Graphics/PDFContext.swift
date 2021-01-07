//
//  File.swift
//  
//
//  Created by Philip Niedertscheider on 03.01.21.
//

import CoreGraphics
import CoreText

/// Encapsulates the graphics context
public class PDFContext {

    private enum Command {
        case beginPDFPage(pageConfig: CFDictionary?)
        case translateBy(x: CGFloat, y: CGFloat)
        case scaleBy(x: CGFloat, y: CGFloat)
    }

    private let cgContext: CGContext

    internal private(set) var currentPageContainsDrawnContent = false
    internal private(set) var hasActivePage = false

    private var delayedCommands: [Command] = []

    internal init(cgContext: CGContext) {
        self.cgContext = cgContext
    }

    // MARK: - PDF

    internal func beginPDFPage(_ pageInfo: CFDictionary?) {
        // Do not create page immediately, instead invoke it as soon as necessary
        delayedCommands.append(.beginPDFPage(pageConfig: pageInfo))
        currentPageContainsDrawnContent = false
        hasActivePage = true
    }

    internal func endPDFPage() {
        applyDelayedCommands()
        cgContext.endPDFPage()
        hasActivePage = false
    }

    internal func closePDF() {
        applyDelayedCommands()
        cgContext.closePDF()
        hasActivePage = false
    }

    // MARK: - Coordinate System

    internal var userSpaceToDeviceSpaceTransform: CGAffineTransform {
        cgContext.userSpaceToDeviceSpaceTransform
    }

    // MARK: - Translation

    internal func translateBy(x: CGFloat, y: CGFloat) {
        delayedCommands.append(.translateBy(x: x, y: y))
    }

    internal func scaleBy(x: CGFloat, y: CGFloat) {
        delayedCommands.append(.scaleBy(x: x, y: y))
    }

    // MARK: - Drawing

    internal func drawPath(using mode: CGPathDrawingMode) {
        applyDelayedCommands()
        cgContext.drawPath(using: mode)
        currentPageContainsDrawnContent = true
    }

    internal func drawPDFPage(_ page: CGPDFPage) {
        applyDelayedCommands()
        cgContext.drawPDFPage(page)
        currentPageContainsDrawnContent = true
    }

    internal func draw(image: CGImage, in frame: CGRect, flipped: Bool) {
        applyDelayedCommands()
        cgContext.draw(image: image, in: frame, flipped: flipped)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Colors

    internal func setFillColor(_ color: CGColor) {
        applyDelayedCommands()
        cgContext.setFillColor(color)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Paths

    internal func beginPath() {
        applyDelayedCommands()
        cgContext.beginPath()
        currentPageContainsDrawnContent = true
    }

    internal func addPath(_ path: CGPath) {
        applyDelayedCommands()
        cgContext.addPath(path)
        currentPageContainsDrawnContent = true
    }

    internal func setLineDash(phase: CGFloat, lengths: [CGFloat]) {
        applyDelayedCommands()
        cgContext.setLineDash(phase: phase, lengths: lengths)
        currentPageContainsDrawnContent = true
    }

    internal func setLineCap(_ cap: CGLineCap) {
        applyDelayedCommands()
        cgContext.setLineCap(cap)
        currentPageContainsDrawnContent = true
    }

    internal func setLineWidth(_ width: CGFloat) {
        applyDelayedCommands()
        cgContext.setLineWidth(width)
        currentPageContainsDrawnContent = true
    }

    internal func setStrokeColor(_ color: CGColor) {
        applyDelayedCommands()
        cgContext.setStrokeColor(color)
        currentPageContainsDrawnContent = true
    }

    // MARK: - State

    internal func saveGState() {
        applyDelayedCommands()
        cgContext.saveGState()
    }

    internal func restoreGState() {
        applyDelayedCommands()
        cgContext.restoreGState()
    }

    // MARK: - CoreText

    internal var textMatrix: CGAffineTransform {
        get {
            cgContext.textMatrix
        }
        set {
            cgContext.textMatrix = newValue
        }
    }

    internal func draw(ctFrame frameRef: CTFrame) {
        applyDelayedCommands()
        CTFrameDraw(frameRef, cgContext)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Masking

    internal func clip() {
        applyDelayedCommands()
        cgContext.clip()
        currentPageContainsDrawnContent = true
    }

    // MARK: - Metadata

    internal func setURL(_ url: CFURL, for rect: CGRect) {
        applyDelayedCommands()
        cgContext.setURL(url, for: rect)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Helpers

    internal func resetDelayedCommands() {
        delayedCommands = []
    }

    private func applyDelayedCommands() {
        for command in delayedCommands {
            switch command {
            case .beginPDFPage(let pageConfig):
                cgContext.beginPDFPage(pageConfig)
            case let .scaleBy(x, y):
                cgContext.scaleBy(x: x, y: y)
            case let .translateBy(x, y):
                cgContext.translateBy(x: x, y: y)
            }
        }
        delayedCommands = []
    }
}
