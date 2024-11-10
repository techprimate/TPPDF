//
//  PDFColumnLayoutState.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

class PDFColumnLayoutState: CustomStringConvertible {
    private var maxColumns: [PDFContainer: Int]
    private var currentColumn: [PDFContainer: Int]
    private var columnWidths: [PDFContainer: [CGFloat]]
    private var columnSpacings: [PDFContainer: [CGFloat]]
    private var wrapColumnsHeight: [PDFContainer: CGFloat]
    private var inset: [PDFContainer: (left: CGFloat, right: CGFloat)]

    init() {
        self.maxColumns = [:]
        self.currentColumn = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0,
        ]
        self.columnWidths = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: [],
        ]
        self.columnSpacings = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: [],
        ]
        self.wrapColumnsHeight = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0,
        ]
        self.inset = [
            .headerLeft: (0, 0),
            .contentLeft: (0, 0),
            .footerLeft: (0, 0),
        ]
    }

    func reset() {
        maxColumns = [:]
        currentColumn = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0,
        ]
        columnWidths = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: [],
        ]
        columnSpacings = [
            .headerLeft: [],
            .contentLeft: [],
            .footerLeft: [],
        ]
        wrapColumnsHeight = [
            .headerLeft: 0,
            .contentLeft: 0,
            .footerLeft: 0,
        ]
        inset = [
            .headerLeft: (0, 0),
            .contentLeft: (0, 0),
            .footerLeft: (0, 0),
        ]
    }

    func set(maxColumns: Int?, for container: PDFContainer) {
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

    func getMaxColumns(for container: PDFContainer) -> Int? {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return maxColumns[.headerLeft]
        case .contentLeft, .contentCenter, .contentRight:
            return maxColumns[.contentLeft]
        case .footerLeft, .footerCenter, .footerRight:
            return maxColumns[.footerRight]
        default:
            return nil
        }
    }

    func set(wrapColumnsHeight: CGFloat, for container: PDFContainer) {
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

    func getWrapColumnsHeight(for container: PDFContainer) -> CGFloat {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return wrapColumnsHeight[.headerLeft] ?? 0
        case .contentLeft, .contentCenter, .contentRight:
            return wrapColumnsHeight[.contentLeft] ?? 0
        case .footerLeft, .footerCenter, .footerRight:
            return wrapColumnsHeight[.footerRight] ?? 0
        default:
            return 0
        }
    }

    func set(currentColumn: Int, for container: PDFContainer) {
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

    func getCurrentColumn(for container: PDFContainer) -> Int {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return currentColumn[.headerLeft] ?? 0
        case .contentLeft, .contentCenter, .contentRight:
            return currentColumn[.contentLeft] ?? 0
        case .footerLeft, .footerCenter, .footerRight:
            return currentColumn[.footerRight] ?? 0
        default:
            return 0
        }
    }

    func set(columnSpacings: [CGFloat], for container: PDFContainer) {
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

    func getColumnSpacings(for container: PDFContainer) -> [CGFloat] {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return columnSpacings[.headerLeft] ?? []
        case .contentLeft, .contentCenter, .contentRight:
            return columnSpacings[.contentLeft] ?? []
        case .footerLeft, .footerCenter, .footerRight:
            return columnSpacings[.footerRight] ?? []
        default:
            return []
        }
    }

    func set(inset: (left: CGFloat, right: CGFloat), for container: PDFContainer) {
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

    func getInset(for container: PDFContainer) -> (left: CGFloat, right: CGFloat) {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return inset[.headerLeft] ?? (0, 0)
        case .contentLeft, .contentCenter, .contentRight:
            return inset[.contentLeft] ?? (0, 0)
        case .footerLeft, .footerCenter, .footerRight:
            return inset[.footerRight] ?? (0, 0)
        default:
            return (0, 0)
        }
    }

    func set(columnWidths: [CGFloat], for container: PDFContainer) {
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

    func getColumnWidths(for container: PDFContainer) -> [CGFloat] {
        switch container {
        case .headerLeft, .headerCenter, .headerRight:
            return columnWidths[.headerLeft] ?? []
        case .contentLeft, .contentCenter, .contentRight:
            return columnWidths[.contentLeft] ?? []
        case .footerLeft, .footerCenter, .footerRight:
            return columnWidths[.footerRight] ?? []
        default:
            return []
        }
    }
}

// MARK: NSCopying

/// nodoc
extension PDFColumnLayoutState: NSCopying {
    /// nodoc
    func copy(with _: NSZone? = nil) -> Any {
        let state = PDFColumnLayoutState()
        state.maxColumns = maxColumns
        state.currentColumn = currentColumn
        state.columnWidths = columnWidths
        state.columnSpacings = columnSpacings
        state.wrapColumnsHeight = wrapColumnsHeight
        state.inset = inset
        return state
    }
}
