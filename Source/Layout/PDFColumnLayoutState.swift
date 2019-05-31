//
//  PDFColumnLayoutState.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 30.05.19.
//

import Foundation
import UIKit

class PDFColumnLayoutState {

    var maxColumns: Int?
    var currentColumn = 0
    var columnWidths: [CGFloat] = []
    var columnSpacings: [CGFloat] = []
    var wrapColumnsHeight: CGFloat = 0

    var inset: (left: CGFloat, right: CGFloat) = (0,0)

}

extension PDFColumnLayoutState: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
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
