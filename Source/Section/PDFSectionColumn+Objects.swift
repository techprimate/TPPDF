//
//  PDFSectionColumn+Objects.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
This extension contains all functions to modify the objects of a section column
*/
public extension PDFSectionColumn {

	// MARK: - PUBLIC FUNCS

	// MARK: - Layout

	/**
	Adds a empty space in the given container, between the previous and the next element
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter space: Space distance in points
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:space:)")
    func addSpace(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, space: CGFloat) {
        add(container, space: space)
    }

	// MARK: - Lines

	/**
	Adds a horizontal line spearator to the given container. The line starts at the left indentation and ends at the right indentation.
	Customize by adjusting parameter `style`.
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter style: Style of line
	*/
    func addLineSeparator(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, style: PDFLineStyle) {
		objects += [(container, PDFLineSeparatorObject(style: style))]
	}

	// MARK: - Image

	/**
	Adds an image to the given container.
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter image: Image object
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, image: PDFImage) {
		objects += [(container, PDFImageObject(image: image))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:image:)")
    func addImage(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, image: PDFImage) {
        add(container, image: image)
    }

	/**
	Adds an image row to the given container.
	This image row will fill the full available width between left indentation and right indentation.
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter imagesInRow: Array of images, from left to right
	- parameter spacing: Horizontal distance between images
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, imagesInRow images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:imagesInRow:spacing:)")
    func addImagesInRow(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, images: [PDFImage], spacing: CGFloat = 5.0) {
        add(container, imagesInRow: images, spacing: spacing)
    }

	// MARK: - Text

	/**
	Shorthand function to add a String text to the given container
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter images: Array of images, from left to right
	- parameter spacing: Horizontal distance between images
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, text: String, lineSpacing: CGFloat = 1.0) {
		add(container, textObject: PDFSimpleText(text: text, spacing: lineSpacing))
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:text:lineSpacing:)")
    func addText(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, text: String, lineSpacing: CGFloat = 1.0) {
        add(container, text: text, lineSpacing: lineSpacing)
    }

	/**
	Adds an text object to the given container
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter textObject: Simple text object
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textObject: PDFSimpleText) {
		objects += [(container, PDFAttributedTextObject(simpleText: textObject))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:textObject:)")
    func addText(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textObject: PDFSimpleText) {
        add(container, textObject: textObject)
    }

	/**
	Shorthand function to add a attributed String text to the given container
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter text: An attributed string
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, attributedText: NSAttributedString) {
		add(container, attributedTextObject: PDFAttributedText(text: attributedText))
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:attributedText:)")
    func addAttributedText(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, text: NSAttributedString) {
        add(container, attributedText: text)
    }

	/**
	Adds an attributed text object to the given container
	
	- parameter container: Container where the space will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter textObject: Attributed text object
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, attributedTextObject: PDFAttributedText) {
		objects += [(container, PDFAttributedTextObject(attributedText: attributedTextObject))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:attributedTextObject:)")
    func addAttributedText(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textObject: PDFAttributedText) {
        add(container, attributedTextObject: textObject)
    }

	/**
	Set font in given container. This text color will be used when adding a `PDFSimpleText`
	
	- parameter container: Container where the font will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter font: Font of text
	*/
    func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, font: UIFont) {
		objects += [(container, PDFFontObject(font: font))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:font:)")
    func setFont(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, font: UIFont) {
        set(container, font: font)
    }

	/**
	Reset text color in given container to default.
	
	- parameter container: Container whose text color will be reset, defaults to `PDFSectionColumnContainer.left`
	*/
    func resetFont(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left) {
		objects += [(container, PDFFontObject(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
	}

	/**
	Set text color in given container. This text color will be used when adding a `PDFSimpleText`
	
	- parameter container: Container where the text color will be set, defaults to `PDFSectionColumnContainer.left`
	- parameter color: Color of the text
	*/
    func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, textColor: UIColor) {
        objects += [(container, PDFTextColorObject(color: textColor))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:textColor:)")
    func setTextColor(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, color: UIColor) {
        set(container, textColor: color)
    }

	/**
	Reset text color in given container to default.
	
	- parameter container: Container whose text color will be reset, defaults to `PDFSectionColumnContainer.left`
	*/
    func resetTextColor(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left) {
		objects += [(container, PDFTextColorObject(color: UIColor.black))]
	}

	// MARK: - Table

	/**
	Adds a table object to the document in the defined container
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:table:)")
    func addTable(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, table: PDFTable) {
        add(container, table: table)
    }

	// MARK: - List

	/**
	Adds a list object to the document in the defined container
	*/
    func add(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "add(_:list:)")
    func addList(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, list: PDFList) {
        add(container, list: list)
    }

	// MARK: - Layout

	/**
	Change the indentation in a container, use the parameter `left` to define from which side.
	
	- parameter container: Container whose indentation should be changed, defaults to `PDFSectionColumnContainer.left`
	- parameter indent: Points from the side
	- parameter left: If `true` then the left side indentation is set, else the right indentation is set
	*/
    func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left))]
    }

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:indet:left:)")
    func setIndentation(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, indent: CGFloat, left: Bool) {
        set(container, indent: indent, left: left)
    }

	/**
	Change the absolute top offset in a container
	
	- parameter container: Container whose current absolute offset should be changed, defaults to `PDFSectionColumnContainer.left`
	- parameter offset: Points from the top
	*/
    func set(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, absoluteOffset: CGFloat) {
		objects += [(container, PDFOffsetObject(offset: absoluteOffset))]
	}

    /**
     TODO: Documentation
     */
    @available(*, deprecated, renamed: "set(_:absoluteOffset:)")
    func setAbsoluteOffset(_ container: PDFSectionColumnContainer = PDFSectionColumnContainer.left, offset: CGFloat) {
        set(container, absoluteOffset: offset)
    }
}
