//
//  PDFSectionColumn.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// A configurable column of a ``PDFSection``
public class PDFSectionColumn: PDFDocumentObject {
    // MARK: - PUBLIC VARS

    /**
     * Holds the relative column width.
     *
     * Value is between `0.0` and `1.0`.
     */
    public private(set) var width: CGFloat

    /// Background color of this section
    public var backgroundColor: Color?

    // MARK: - INTERNAL VARS

    /// All objects inside the document and the container they are located in
    var objects: [(PDFSectionColumnContainer, PDFRenderObject)] = []

    // MARK: - PUBLIC INITIALIZERS

    /**
     * Creates a new section column with the given relative width.
     *
     * - Parameter width: See ``PDFSectionColumn/width`` for details
     */
    public init(width: CGFloat) {
        self.width = width
    }

    /// nodoc
    var copy: PDFSectionColumn {
        PDFSectionColumn(width: width)
    }

    // MARK: - Layout

    /**
     * Adds a empty space in the given container, between the previous and the next element
     *
     * - Parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
     * - Parameter space: Space distance in points
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    // MARK: - Lines

    /**
     * Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
     * Customize by adjusting parameter `style`.
     *
     * - Parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
     * - Parameter style: Style of line
     */
    public func addLineSeparator(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }

    // MARK: - Image

    /**
     * Adds an image to the given container.
     *
     * - Parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
     * - Parameter image: Image object
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }

    /**
     * Adds an image row to the given container.
     * This image row will fill the full available width between left indentation and right indentation.
     *
     * - Parameters:
     *     - container: Container where the space will be set
     *     - images: Array of images, from left to
     *     - spacing: Horizontal distance between images
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, imagesInRow images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }

    // MARK: - Text

    /**
     Shorthand public function to add a String text to the given container

     - Parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
     - Parameter images: Array of images, from left to right
     - Parameter spacing: Horizontal distance between images
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
    }

    /**
     * Adds an text object to the given container
     *
     * - Parameter container: Container where the space will be set
     * - Parameter textObject: Simple text object
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textObject: PDFSimpleText) {
        objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
    }

    /**
     * Shorthand public function to add a attributed String text to the given container
     *
     * - Parameter container: Container where the space will be set
     * - Parameter text: An attributed string
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, attributedText: NSAttributedString) {
        add(container, attributedTextObject: PDFAttributedText(text: attributedText))
    }

    /**
     * Adds an attributed text object to the given container
     *
     * - Parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     * - Parameter textObject: Attributed text object
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, attributedTextObject: PDFAttributedText) {
        objects += [(container, PDFAttributedTextObject(attributedText: attributedTextObject))]
    }

    /**
     * Set font in given container. This text color will be used when adding a `PDFSimpleText`
     *
     * - Parameter container: Container where the font will be set, defaults to `PDFContainer.contentLeft`
     * - Parameter font: Font of text
     */
    public func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, font: Font) {
        objects += [(container, PDFFontObject(font: font))]
    }

    /**
     * Reset text color in given container to default.
     *
     * - Parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    public func resetFont(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left) {
        objects += [(container, PDFFontObject(font: Font.systemFont(ofSize: PDFConstants.defaultFontSize)))]
    }

    /**
     * Set text color in given container. This text color will be used when adding a `PDFSimpleText`
     *
     * - Parameter container: Container where the text color will be set, defaults to `PDFContainer.contentLeft`
     * - Parameter color: Color of the text
     */
    public func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textColor: Color) {
        objects += [(container, PDFTextColorObject(color: textColor))]
    }

    /**
     * Reset text color in given container to default.
     *
     * - Parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    public func resetTextColor(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left) {
        objects += [(container, PDFTextColorObject(color: Color.black))]
    }

    // MARK: - Table

    /**
     * Adds a table object to the document in the defined container
     *
     * - Parameter container: Container where the table color will be added, defaults to `PDFContainer.contentLeft`
     * - Parameter color: Table to add to document
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    // MARK: - List

    /**
     * Adds a list object to the document in the defined container
     *
     * - Parameter container: Container where the text color will be set, defaults to `PDFContainer.contentLeft`
     * - Parameter color: Color of the text
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

    // MARK: - Layout

    /**
     * Change the indentation in a container, use the parameter `left` to define from which side.
     *
     * - Parameters:
     *    - container: Container whose indentation should be changed, defaults to `PDFContainer.contentLeft`
     *    - indent: Points from the side
     *    - left: If `true` then the left side indentation is set, else the right indentation is set
     */
    public func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left, insideSectionColumn: true))]
    }

    /**
     * Change the absolute top offset in a container
     *
     * - Parameter container: Container whose current absoilute offset should be changed, defaults to `PDFContainer.contentLeft`
     * - Parameter absoluteOffset: Points from the top
     */
    public func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, absoluteOffset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: absoluteOffset))]
    }

    // MARK: - Groups

    /**
     * Adds a group
     *
     * - Parameter container: Container where the group will be added
     * - Parameter group: Instance of ``PDFGroup`` to add
     */
    public func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, group: PDFGroup) {
        objects += [(container, PDFGroupObject(
            objects: group.objects,
            allowsBreaks: group.allowsBreaks,
            isFullPage: false,
            backgroundColor: group.backgroundColor,
            backgroundImage: group.backgroundImage,
            backgroundShape: group.backgroundShape,
            outline: group.outline,
            padding: group.padding
        ))]
    }
}
