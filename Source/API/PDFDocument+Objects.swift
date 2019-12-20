//
//  PDFDocument+Objects.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 This extension contains all functions to modify the objects of a document
 */
public extension PDFDocument {

    // MARK: - PUBLIC FUNCS

    // MARK: - Layout

    /**
     Adds a empty space in the given container, between the previous and the next element

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter space: Space distance in points
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:space:)")
    func addSpace(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        add(container, space: space)
    }

    // MARK: - Lines

    /**
     Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
     Customize by adjusting parameter `style`.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter style: Style of line
     */
    func addLineSeparator(_ container: PDFContainer = PDFContainer.contentLeft, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }

    // MARK: - Image

    /**
     Adds an image to the given container.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter image: Image object
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:image:)")
    func addImage(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        add(container, image: image)
    }

    /**
     Adds an image row to the given container.
     This image row will fill the full available width between left indentation and right indentation.

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, imagesInRow images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:imagesInRow:spacing:)")
    func addImagesInRow(_ container: PDFContainer = PDFContainer.contentLeft, images: [PDFImage], spacing: CGFloat = 5.0) {
        add(container, imagesInRow: images, spacing: spacing)
    }

    // MARK: - Text

    /**
     Shorthand function to add a String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter images: Array of images, from left to right
     - parameter spacing: Horizontal distance between images
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:text:lineSpacing:)")
    func addText(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, text: text, lineSpacing: lineSpacing)
    }

    /**
     Adds an text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Simple text object
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, textObject: PDFSimpleText) {
        objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:textObject:)")
    func addText(_ container: PDFContainer = PDFContainer.contentLeft, textObject: PDFSimpleText) {
        add(container, textObject: textObject)
    }

    /**
     Shorthand function to add a attributed String text to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter text: An attributed string
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, attributedText: NSAttributedString) {
        add(container, attributedTextObject: PDFAttributedText(text: attributedText))
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:attributedText:)")
    func addAttributedText(_ container: PDFContainer = PDFContainer.contentLeft, text: NSAttributedString) {
        add(container, attributedText: text)
    }

    /**
     Adds an attributed text object to the given container

     - parameter container: Container where the space will be set, defaults to `PDFContainer.contentLeft`
     - parameter textObject: Attributed text object
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, attributedTextObject: PDFAttributedText) {
        objects += [(container, PDFAttributedTextObject(attributedText: attributedTextObject))]
    }

    /**
     Set font in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the font will be set, defaults to `PDFContainer.contentLeft`
     - parameter font: Font of text
     */
    func set(_ container: PDFContainer = PDFContainer.contentLeft, font: UIFont) {
        objects += [(container, PDFFontObject(font: font))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:font:)")
    func setFont(_ container: PDFContainer = PDFContainer.contentLeft, font: UIFont) {
        set(container, font: font)
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    func resetFont(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFFontObject(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
    }

    /**
     Set text color in given container. This text color will be used when adding a `PDFSimpleText`

     - parameter container: Container where the text color will be set, defaults to `PDFContainer.contentLeft`
     - parameter color: Color of the text
     */
    func set(_ container: PDFContainer = PDFContainer.contentLeft, textColor: UIColor) {
        objects += [(container, PDFTextColorObject(color: textColor))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:textColor:)")
    func setTextColor(_ container: PDFContainer = PDFContainer.contentLeft, color: UIColor) {
        objects += [(container, PDFTextColorObject(color: color))]
    }

    /**
     Reset text color in given container to default.

     - parameter container: Container whose text color will be reset, defaults to `PDFContainer.contentLeft`
     */
    func resetTextColor(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFTextColorObject(color: UIColor.black))]
    }

    // MARK: - Table

    /**
     Adds a table object to the document in the defined container
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:table:)")
    func addTable(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        add(container, table: table)
    }

    // MARK: - List

    /**
     Adds a list object to the document in the defined container
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:table:)")
    func addList(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        add(container, list: list)
    }

	// MARK: - Section

	/**
	 Adds a section object to the document
	 */
    func add(section: PDFSection) {
		objects += [(.contentLeft, PDFSectionObject(section: section))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:section:)")
    func addSection(_ section: PDFSection) {
        add(section: section)
    }

    // MARK: - Layout

    /**
     Change the indentation in a container, use the parameter `left` to define from which side.

     - parameter container: Container whose indentation should be changed, defaults to `PDFContainer.contentLeft`
     - parameter indent: Points from the side
     - parameter left: If `true` then the left side indentation is set, else the right indentation is set
     */
    func set(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:indent:left:)")
    func setIndentation(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat, left: Bool) {
        set(container, indent: indent, left: left)
    }

    /**
     Change the absolute top offset in a container

     - parameter container: Container whose current absoilute offset should be changed, defaults to `PDFContainer.contentLeft`
     - parameter absoluteOffset: Points from the top
     */
    func set(_ container: PDFContainer = PDFContainer.contentLeft, absoluteOffset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: absoluteOffset))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:absoluteOffset:)")
    func setAbsoluteOffset(_ container: PDFContainer = PDFContainer.contentLeft, offset: CGFloat) {
        set(container, absoluteOffset: offset)
    }

    /**
     Creates a new page
     */
    func createNewPage() {
        objects += [(.contentLeft, PDFPageBreakObject())]
    }

    /**
     Adds a style to the index
     */
    func add(style: PDFTextStyle) -> PDFTextStyle {
        self.styles.append(style)
        return style
    }

    /**
     Adds a table of content
     */
    func add(tableOfContent: PDFTableOfContent) {
        objects += [(.contentLeft, PDFTableOfContentObject(list: PDFList(indentations: []), options: tableOfContent))]
    }

    // MARK: - Column Wrapping

    /**
     Starts a column section with automatic wrapping
     */
    func enable(_ container: PDFContainer = PDFContainer.contentLeft, columns: Int, widths: [CGFloat], spacings: [CGFloat]) {
        assert(columns > 1, "A column wrap section must have more than one column")
        assert(widths.count >= columns, "A colum wrap section must have at least the same amount of width values as columns")
        assert(spacings.count == widths.count - 1, "A colum wrap section must have exactly one less spacing value than the widths")
        objects += [(container, PDFColumnWrapSectionObject(columns: columns, widths: widths, spacings: spacings))]
    }

    /**
     Finishes a column section
     */
    func disableColumns(_ container: PDFContainer = PDFContainer.contentLeft, addPageBreak: Bool = true) {
        objects += [(container, PDFColumnWrapSectionObject(isDisable: true, addPageBreak: addPageBreak))]
    }

    /**
     TODO: Documentation
     */
    func add(_ container: PDFContainer = PDFContainer.contentLeft, group: PDFGroup) {
        objects += [(container, PDFGroupObject(objects: group.objects,
                                               allowsBreaks: group.allowsBreaks,
                                               isFullPage: false,
                                               backgroundColor: group.backgroundColor,
                                               backgroundImage: group.backgroundImage,
                                               backgroundShape: group.backgroundShape,
                                               outline: group.outline,
                                               padding: group.padding))]
    }

    /**
     TODO: Documentation
     */
    func set(master group: PDFMasterGroup) {
        self.masterGroup = PDFGroupObject(objects: group.objects,
                                          allowsBreaks: group.allowsBreaks,
                                          isFullPage: group.isFullPage,
                                          backgroundColor: group.backgroundColor,
                                          backgroundImage: group.backgroundImage,
                                          backgroundShape: group.backgroundShape,
                                          outline: group.outline,
                                          padding: group.padding)
    }

    /**
     TODO: Documentation
     */
    func add(externalDocument doc: PDFExternalDocument) {
        objects += [(.none, PDFExternalDocumentObject(url: doc.url,
                                                      pages: doc.pages))]
    }
}
