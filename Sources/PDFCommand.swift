//
//  PDFCommand.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//
//

import UIKit

public enum PDFCommand {
    
    case addText(text: String, lineSpacing: CGFloat)
    case addAttributedText(text: NSAttributedString)
    case addImage(image: UIImage, size: CGSize, caption: NSAttributedString, sizeFit: ImageSizeFit)
    case addImagesInRow(images: [UIImage], captions: [NSAttributedString], spacing: CGFloat)
    case addSpace(space: CGFloat)
    case addLineSeparator(style: PDFLineStyle)
    case addTable(table: PDFTable)
    case addList(list: List)
    
    case setIndentation(points: CGFloat)
    case setOffset(points: CGFloat)
    case setFont(font: UIFont)
    case setTextColor(color: UIColor)
    
    case createNewPage()
}
