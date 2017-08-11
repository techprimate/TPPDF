//
//  PDFGenerator+Commands.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    // MARK: - Lines
    
    open func addLineSeparator(_ container: PDFContainer = PDFContainer.contentLeft, style: PDFLineStyle) {
        commands += [(container, .addLineSeparator(style: style))]
    }
   
    // MARK: - Text
    
    open func addText(_ container: PDFContainer = PDFContainer.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        commands += [(container, .addText(text: text, lineSpacing: lineSpacing))]
    }
    
    open func addAttributedText(_ container: PDFContainer = PDFContainer.contentLeft, text: NSAttributedString) {
        commands += [(container, .addAttributedText(text: text))]
    }
    
    open func setFont(_ container: PDFContainer = PDFContainer.contentLeft, font: UIFont) {
        commands += [(container, .setFont(font: font))]
    }
    
    open func resetFont(_ container: PDFContainer = PDFContainer.contentLeft) {
        commands += [(container, .setFont(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
    }
    
    open func setTextColor(_ container: PDFContainer = PDFContainer.contentLeft, color: UIColor) {
        commands += [(container, .setTextColor(color: color))]
    }
    
    open func resetTextColor(_ container: PDFContainer = PDFContainer.contentLeft) {
        commands += [(container, .setTextColor(color: UIColor.black))]
    }
    
    
    // MARK: - Image
    
    open func addImage(_ container: PDFContainer = PDFContainer.contentLeft, image: PDFImage) {
        commands += [(container, .addImage(image: image.image, size: image.size, caption: image.caption, sizeFit: image.sizeFit))]
    }
    
    open func addImagesInRow(_ container: PDFContainer = PDFContainer.contentLeft, images: [PDFImage], spacing: CGFloat = 5.0) {
        let imagesArray = images.map { return $0.image }
        let captionsArray = images.map { return $0.caption }
        
        commands += [(container, .addImagesInRow(images: imagesArray, captions: captionsArray, spacing: spacing))]
    }
    
    // MARK: - Table
    
    open func addTable(_ container: PDFContainer = PDFContainer.contentLeft, table: PDFTable) {
        commands += [(container, .addTable(table: table))]
    }
    
    // MARK: - List
    
    open func addList(_ container: PDFContainer = PDFContainer.contentLeft, list: PDFList) {
        commands += [(container, .addList(list: list))]
    }

    // MARK: - PDFContainer
    
    open func addSpace(_ container: PDFContainer = PDFContainer.contentLeft, space: CGFloat) {
        commands += [(container, .addSpace(space: space))]
    }
    
    open func setIndentation(_ container: PDFContainer = PDFContainer.contentLeft, indent: CGFloat) {
        commands += [(container, .setIndentation(points: indent))]
    }
    
    open func setAbsoluteOffset(_ container: PDFContainer = PDFContainer.contentLeft, offset: CGFloat) {
        commands += [(container, .setOffset(points: offset))]
    }
   
    open func createNewPage() {
        commands += [(.contentLeft, .createNewPage())]
    }
}
