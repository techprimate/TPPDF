//
//  PDFDocument+Commands.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
//

/**
 This extension contains all functions to modify the objects of a document
 */
public extension PDFDocument {
    
    // MARK: - Layout
    
    public func addSpace(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        objects += [(container, PDFSpaceObject(space: space))]
    }
    
    // MARK: - Lines
    
    public func addLineSeparator(_ container: PDFContainer = PDFContainer.contentLeft, style: PDFLineStyle) {
        objects += [(container, PDFLineSeparatorObject(style: style))]
    }
    
    // MARK: - Image

    public func addImage(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        objects += [(container, PDFImageObject(image: image))]
    }
    
    public func addImagesInRow(_ container: PDFContainer = PDFContainer.contentLeft, images: [PDFImage], spacing: CGFloat = 5.0) {
        objects += [(container, PDFImageRowObject(images: images, spacing: spacing))]
    }
    
    // MARK: - Text

    public func addText(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        objects += [(container, PDFAttributedTextObject(text: text, spacing: lineSpacing))]
    }

    public func addAttributedText(_ container: PDFContainer = PDFContainer.contentLeft, text: NSAttributedString) {
        objects += [(container, PDFAttributedTextObject(attributedText: text))]
    }
    
    public func setFont(_ container: PDFContainer = PDFContainer.contentLeft, font: UIFont) {
        objects += [(container, PDFFontObject(font: font))]
    }
    
    public func resetFont(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFFontObject(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
    }
    
    public func setTextColor(_ container: PDFContainer = PDFContainer.contentLeft, color: UIColor) {
        objects += [(container, PDFTextColorObject(color: color))]
    }
    
    public func resetTextColor(_ container: PDFContainer = PDFContainer.contentLeft) {
        objects += [(container, PDFTextColorObject(color: UIColor.black))]
    }
    
    // MARK: - Table
    
    /**
     Adds a table object to the document in the defined container
     */
    public func addTable(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        objects += [(container, PDFTableObject(table: table))]
    }
    
    // MARK: - List
    
    /**
     Adds a list object to the document in the defined container
     */
    public func addList(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        objects += [(container, PDFListObject(list: list))]
    }
    
    // MARK: - Layout
    
    /**
     Change the indentation in a container, use the parameter `left` to define from which side.
     
     - parameter container: Container whose indentation should be changed, defaults to `PDFContainer.contentLeft`
     - parameter indent: Points from the side
     - parameter left: If `true` then the left side indentation is set, else the right indentation is set
     */
    public func setIndentation(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat, left: Bool) {
        objects += [(container, PDFIndentationObject(indentation: indent, left: left))]
    }
    
    /**
     Change the absolute top offset in a container
     
     - parameter container: Container whose current absoilute offset should be changed, defaults to `PDFContainer.contentLeft`
     - parameter offset: Points from the top
     */
    public func setAbsoluteOffset(_ container: PDFContainer = PDFContainer.contentLeft, offset: CGFloat) {
        objects += [(container, PDFOffsetObject(offset: offset))]
    }
    
    /**
     Creates a new page
     */
    public func createNewPage() {
        objects += [(.contentLeft, PDFPageBreakObject())]
    }
}
