//
//  PDFColumnLayoutState.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation
import UIKit

/**
 TODO: Documentation
 */
internal class PDFColumnLayoutState {

    /**
     TODO: Documentation
     */
    internal var maxColumns: Int?

    /**
     TODO: Documentation
     */
    internal var currentColumn = 0

    /**
     TODO: Documentation
     */
    internal var columnWidths: [CGFloat] = []

    /**
     TODO: Documentation
     */
    internal var columnSpacings: [CGFloat] = []

    /**
     TODO: Documentation
     */
    internal var wrapColumnsHeight: CGFloat = 0

    /**
     TODO: Documentation
     */
    internal var inset: (left: CGFloat, right: CGFloat) = (0, 0)

    /**
     TODO: Documentation
     */
    internal func reset() {
        maxColumns = nil
        currentColumn = 0
        columnWidths = []
        columnSpacings = []
        wrapColumnsHeight = 0
        inset = (0, 0)
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
