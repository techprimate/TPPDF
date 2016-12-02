//
//  Command.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 12/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit

enum Command {
    
    case addText(text: String, lineSpacing: CGFloat)
    case addAttributedText(text: NSAttributedString)
    case addImage(image: UIImage, size: CGSize, caption: NSAttributedString)
    case addImagesInRow(images: [UIImage], captions: [NSAttributedString], spacing: CGFloat)
    case addSpace(space: CGFloat)
    case addLineSeparator(thickness: CGFloat, color: UIColor)
    case addTable(data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat, margin: CGFloat, textColor: UIColor, lineColor: UIColor, lineWidth: CGFloat, drawCellBounds: Bool)
    
    case setIndentation(points: CGFloat)
    case setOffset(points: CGFloat)
    
    case createNewPage()
}
