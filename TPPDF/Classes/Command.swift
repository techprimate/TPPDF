//
//  Command.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 12/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit

enum Command {
    
    case AddText(text: String, lineSpacing: CGFloat)
    case AddAttributedText(text: NSAttributedString)
    case AddImage(image: UIImage, size: CGSize)
    case AddSpace(space: CGFloat)
    case AddLineSeparator(thickness: CGFloat, color: UIColor)
    case AddTable(data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, textColor: UIColor, lineColor: UIColor, lineWidth: CGFloat, drawCellBounds: Bool)
}
