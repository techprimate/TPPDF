//
//  PDFColumnLayoutState.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 TODO: Documentation
 */
internal class PDFColumnLayoutState: CustomStringConvertible {

    /**
     TODO: Documentation
     */
    private var maxColumns: [PDFContainer: Int]

    /**
     TODO: Documentation
     */
    private var currentColumn: [PDFContainer: Int]

    /**
     TODO: Documentation
     */
    private var columnWidths: [PDFContainer: [CGFloat]]

    /**
     TODO: Documentation
     */
    private var columnSpacings: [PDFContainer: [CGFloat]]

    /**
     TODO: Documentation
     */
    private var wrapColumnsHeight: [PDFContainer: CGFloat]

    /**
     TODO: Documentation
     */
    private var inset: [PDFContainer: (left: CGFloat, right: CGFloat)]

    /**
     TODO: Documentation
     */
    internal init() {
        maxColumns = [:]
        currentColumn = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0
        ]
        columnWidths = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: []
        ]
        columnSpacings = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: []
        ]
        wrapColumnsHeight = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0
        ]
        inset = [
            .headerLeft: (0, 0),
            .contentLeft: (0, 0),
            .footerLeft: (0, 0)
        ]
    }

    /**
     TODO: Documentation
     */
    internal func reset() {
        maxColumns = [:]
        currentColumn = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0
        ]
        columnWidths = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: []
        ]
        columnSpacings = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: []
        ]
        wrapColumnsHeight = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0
        ]
        inset = [
            .headerLeft: (0, 0),
            .contentLeft: (0, 0),
            .footerLeft: (0, 0)
        ]
    }

    /**
     TODO: Documentation
     */
    internal func set(maxColumns: Int?, for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.maxColumns[.headerLeft] = maxColumns
        case .contentLeft, .contentCenter, .contentRight:
            self.maxColumns[.contentLeft] = maxColumns
        case .footerLeft, .footerCenter, .footerRight:
            self.maxColumns[.footerRight] = maxColumns
        default:
            break
        }
    }

    internal func getMaxColumns(for container: PDFContainer) -> Int? {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.maxColumns[.headerLeft]
        case .contentLeft, .contentCenter, .contentRight:
            return self.maxColumns[.contentLeft]
        case .footerLeft, .footerCenter, .footerRight:
            return self.maxColumns[.footerRight]
        default:
            return nil
        }
    }

    /**
     TODO: Documentation
     */
    internal func set(wrapColumnsHeight: CGFloat, for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.wrapColumnsHeight[.headerLeft] = wrapColumnsHeight
        case .contentLeft, .contentCenter, .contentRight:
            self.wrapColumnsHeight[.contentLeft] = wrapColumnsHeight
        case .footerLeft, .footerCenter, .footerRight:
            self.wrapColumnsHeight[.footerRight] = wrapColumnsHeight
        default:
            break
        }
    }

    internal func getWrapColumnsHeight(for container: PDFContainer) -> CGFloat {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.wrapColumnsHeight[.headerLeft] ?? 0
        case .contentLeft, .contentCenter, .contentRight:
            return self.wrapColumnsHeight[.contentLeft] ?? 0
        case .footerLeft, .footerCenter, .footerRight:
            return self.wrapColumnsHeight[.footerRight] ?? 0
        default:
            return 0
        }
    }

    /**
     TODO: Documentation
     */
    internal func set(currentColumn: Int, for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.currentColumn[.headerLeft] = currentColumn
        case .contentLeft, .contentCenter, .contentRight:
            self.currentColumn[.contentLeft] = currentColumn
        case .footerLeft, .footerCenter, .footerRight:
            self.currentColumn[.footerRight] = currentColumn
        default:
            break
        }
    }

    internal func getCurrentColumn(for container: PDFContainer) -> Int {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.currentColumn[.headerLeft] ?? 0
        case .contentLeft, .contentCenter, .contentRight:
            return self.currentColumn[.contentLeft] ?? 0
        case .footerLeft, .footerCenter, .footerRight:
            return self.currentColumn[.footerRight] ?? 0
        default:
            return 0
        }
    }

    /**
     TODO: Documentation
     */
    internal func set(columnSpacings: [CGFloat], for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.columnSpacings[.headerLeft] = columnSpacings
        case .contentLeft, .contentCenter, .contentRight:
            self.columnSpacings[.contentLeft] = columnSpacings
        case .footerLeft, .footerCenter, .footerRight:
            self.columnSpacings[.footerRight] = columnSpacings
        default:
            break
        }
    }

    internal func getColumnSpacings(for container: PDFContainer) -> [CGFloat] {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.columnSpacings[.headerLeft] ?? []
        case .contentLeft, .contentCenter, .contentRight:
            return self.columnSpacings[.contentLeft] ?? []
        case .footerLeft, .footerCenter, .footerRight:
            return self.columnSpacings[.footerRight] ?? []
        default:
            return []
        }
    }

    /**
     TODO: Documentation
     */
    internal func set(inset: (left: CGFloat, right: CGFloat), for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.inset[.headerLeft] = inset
        case .contentLeft, .contentCenter, .contentRight:
            self.inset[.contentLeft] = inset
        case .footerLeft, .footerCenter, .footerRight:
            self.inset[.footerRight] = inset
        default:
            break
        }
    }

    internal func getInset(for container: PDFContainer) -> (left: CGFloat, right: CGFloat) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.inset[.headerLeft] ?? (0, 0)
        case .contentLeft, .contentCenter, .contentRight:
            return self.inset[.contentLeft] ?? (0, 0)
        case .footerLeft, .footerCenter, .footerRight:
            return self.inset[.footerRight] ?? (0, 0)
        default:
            return (0, 0)
        }
    }

    /**
     TODO: Documentation
     */
    internal func set(columnWidths: [CGFloat], for container: PDFContainer) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            self.columnWidths[.headerLeft] = columnWidths
        case .contentLeft, .contentCenter, .contentRight:
            self.columnWidths[.contentLeft] = columnWidths
        case .footerLeft, .footerCenter, .footerRight:
            self.columnWidths[.footerRight] = columnWidths
        default:
            break
        }
    }

    internal func getColumnWidths(for container: PDFContainer) -> [CGFloat] {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return self.columnWidths[.headerLeft] ?? []
        case .contentLeft, .contentCenter, .contentRight:
            return self.columnWidths[.contentLeft] ?? []
        case .footerLeft, .footerCenter, .footerRight:
            return self.columnWidths[.footerRight] ?? []
        default:
            return []
        }
    }
}

/**
 TODO: Documentation
 */
extension PDFColumnLayoutState: NSCopying {

    /**
     TODO: Documentation
     */
    internal func copy(with zone: NSZone? = nil) -> Any {
        let state = PDFColumnLayoutState()
        state.maxColumns = self.maxColumns
        state.currentColumn = self.currentColumn
        state.columnWidths = self.columnWidths
        state.columnSpacings = self.columnSpacings
        state.wrapColumnsHeight = self.wrapColumnsHeight
        state.inset = self.inset
        return state
    }
}
