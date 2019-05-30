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
