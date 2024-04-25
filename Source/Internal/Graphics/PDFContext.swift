//
//  PDFContext.swift
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

    private(set) var currentPageContainsDrawnContent = false
    private(set) var hasActivePage = false

    private var delayedCommands: [Command] = []

    init(cgContext: CGContext) {
        self.cgContext = cgContext
    }

    // MARK: - PDF

    func beginPDFPage(_ pageInfo: CFDictionary?) {
        // Do not create page immediately, instead invoke it as soon as necessary
        delayedCommands.append(.beginPDFPage(pageConfig: pageInfo))
        currentPageContainsDrawnContent = false
        hasActivePage = true
    }

    func endPDFPage() {
        applyDelayedCommands()
        cgContext.endPDFPage()
        hasActivePage = false
    }

    func closePDF() {
        applyDelayedCommands()
        cgContext.closePDF()
        hasActivePage = false
    }

    // MARK: - Coordinate System

    var userSpaceToDeviceSpaceTransform: CGAffineTransform {
        cgContext.userSpaceToDeviceSpaceTransform
    }

    // MARK: - Translation

    func translateBy(x: CGFloat, y: CGFloat) {
        delayedCommands.append(.translateBy(x: x, y: y))
    }

    func scaleBy(x: CGFloat, y: CGFloat) {
        delayedCommands.append(.scaleBy(x: x, y: y))
    }

    // MARK: - Drawing

    func drawPath(using mode: CGPathDrawingMode) {
        applyDelayedCommands()
        cgContext.drawPath(using: mode)
        currentPageContainsDrawnContent = true
    }

    func drawPDFPage(_ page: CGPDFPage) {
        applyDelayedCommands()
        cgContext.drawPDFPage(page)
        currentPageContainsDrawnContent = true
    }

    func draw(image: CGImage, in frame: CGRect, flipped: Bool) {
        applyDelayedCommands()
        cgContext.draw(image: image, in: frame, flipped: flipped)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Colors

    func setFillColor(_ color: CGColor) {
        applyDelayedCommands()
        cgContext.setFillColor(color)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Paths

    func beginPath() {
        applyDelayedCommands()
        cgContext.beginPath()
        currentPageContainsDrawnContent = true
    }

    func addPath(_ path: CGPath) {
        applyDelayedCommands()
        cgContext.addPath(path)
        currentPageContainsDrawnContent = true
    }

    func setLineDash(phase: CGFloat, lengths: [CGFloat]) {
        applyDelayedCommands()
        cgContext.setLineDash(phase: phase, lengths: lengths)
        currentPageContainsDrawnContent = true
    }

    func setLineCap(_ cap: CGLineCap) {
        applyDelayedCommands()
        cgContext.setLineCap(cap)
        currentPageContainsDrawnContent = true
    }

    func setLineWidth(_ width: CGFloat) {
        applyDelayedCommands()
        cgContext.setLineWidth(width)
        currentPageContainsDrawnContent = true
    }

    func setStrokeColor(_ color: CGColor) {
        applyDelayedCommands()
        cgContext.setStrokeColor(color)
        currentPageContainsDrawnContent = true
    }

    // MARK: - State

    func saveGState() {
        applyDelayedCommands()
        cgContext.saveGState()
    }

    func restoreGState() {
        applyDelayedCommands()
        cgContext.restoreGState()
    }

    // MARK: - CoreText

    var textMatrix: CGAffineTransform {
        get {
            cgContext.textMatrix
        }
        set {
            cgContext.textMatrix = newValue
        }
    }

    func draw(ctFrame frameRef: CTFrame) {
        applyDelayedCommands()
        CTFrameDraw(frameRef, cgContext)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Masking

    func clip() {
        applyDelayedCommands()
        cgContext.clip()
        currentPageContainsDrawnContent = true
    }

    // MARK: - Metadata

    func setURL(_ url: CFURL, for rect: CGRect) {
        applyDelayedCommands()
        cgContext.setURL(url, for: rect)
        currentPageContainsDrawnContent = true
    }

    // MARK: - Helpers

    func resetDelayedCommands() {
        delayedCommands = []
    }

    private func applyDelayedCommands() {
        for command in delayedCommands {
            switch command {
            case let .beginPDFPage(pageConfig):
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
