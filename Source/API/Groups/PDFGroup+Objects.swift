//
//  PDFGroup+Objects.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
 This extension contains all functions to modify the objects of a group
 */
public extension PDFGroup {

    // MARK: - PUBLIC FUNCS

    // MARK: - Layout

    /**
     Adds a empty space in the given container, between the previous and the next element

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter space: Space distance in points
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    // MARK: - Lines

    /**
     Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
     Customize by adjusting parameter `style`.

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter style: Style of line
     */
    func addLineSeparator(_ container: PDFGroupContainer = PDFGroupContainer.left, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }

    // MARK: - Image

    /**
     Adds an image to the given container.

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter image: Image object
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }

    /**
     Adds an image row to the given container.
     This image row will fill the full available width between left indentation and right indentation.

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, imagesInRow: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: imagesInRow, spacing: spacing))]
    }

    // MARK: - Text

    /**
     Shorthand function to add a String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
    }

    /**
     Adds an text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter textObject: Simple text object
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, textObject: PDFSimpleText) {
        objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
    }

    /**
     Shorthand function to add a attributed String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter text: An attributed string
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, attributedText: NSAttributedString) {
        add(container, attributedTextObject: PDFAttributedText(text: attributedText))
    }

    /**
     Adds an attributed text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFGroupContainer.left`
     - parameter textObject: Attributed text object
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, attributedTextObject: PDFAttributedText) {
        objects += [(container, PDFAttributedTextObject(attributedText: attributedTextObject))]
    }

    /**
     Set font in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the font will be set, defaults to `PDFGroupContainer.left`
     - parameter font: Font of text
     */
    func set(_ container: PDFGroupContainer = PDFGroupContainer.left, font: Font) {
        objects += [(container, PDFFontObject(font: font))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFGroupContainer.left`
     */
    func resetFont(_ container: PDFGroupContainer = PDFGroupContainer.left) {
        objects += [(container, PDFFontObject(font: Font.systemFont(ofSize: PDFConstants.defaultFontSize)))]
    }

    /**
     Set text color in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the text color will be set, defaults to `PDFGroupContainer.left`
     - parameter color: Color of the text
     */
    func set(_ container: PDFGroupContainer = PDFGroupContainer.left, textColor: Color) {
        objects += [(container, PDFTextColorObject(color: textColor))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFGroupContainer.left`
     */
    func resetTextColor(_ container: PDFGroupContainer = PDFGroupContainer.left) {
        objects += [(container, PDFTextColorObject(color: Color.black))]
    }

    // MARK: - Table

    /**
     Adds a table object to the document in the defined container
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    // MARK: - List

    /**
     Adds a list object to the document in the defined container
     */
    func add(_ container: PDFGroupContainer = PDFGroupContainer.left, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

    // MARK: - Layout

    /**
     Change the indentation in a container, use the parameter `left` to define from which side.

     - parameter container: Container whose indentation should be changed, defaults to `PDFGroupContainer.left`
     - parameter indent: Points from the side
     - parameter left: If `true` then the left side indentation is set, else the right indentation is set
     */
    func set(_ container: PDFGroupContainer = PDFGroupContainer.left, indentation: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indentation, left: left, insideSectionColumn: false))]
    }

    /**
     Change the absolute top offset in a container

     - parameter container: Container whose current absolute offset should be changed, defaults to `PDFGroupContainer.left`
     - parameter offset: Points from the top
     */
    func set(_ container: PDFGroupContainer = PDFGroupContainer.left, absoluteOffset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: absoluteOffset))]
    }
}
