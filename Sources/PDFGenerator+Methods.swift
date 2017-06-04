//
//  PDFGenerator+Commands.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    // MARK: - Lines
    
    open func addLineSeparator(_ container: Container = Container.contentLeft, style: LineStyle) {
        commands += [(container, .addLineSeparator(style: style))]
    }
   
    // MARK: - Text
    
    open func addText(_ container: Container = Container.contentLeft, text: String, lineSpacing: CGFloat = 1.0) {
        commands += [(container, .addText(text: text, lineSpacing: lineSpacing))]
    }
    
    open func addAttributedText(_ container: Container = Container.contentLeft, text: NSAttributedString) {
        commands += [(container, .addAttributedText(text: text))]
    }
    
    open func setFont(_ container: Container = Container.contentLeft, font: UIFont) {
        commands += [(container, .setFont(font: font))]
    }
    
    open func resetFont(_ container: Container = Container.contentLeft) {
        commands += [(container, .setFont(font: UIFont.systemFont(ofSize: UIFont.systemFontSize)))]
    }
    
    // MARK: - Image
    
    open func addImage(_ container: Container = Container.contentLeft, image: UIImage, size: CGSize = CGSize.zero, caption: NSAttributedString = NSAttributedString(), sizeFit: ImageSizeFit = .widthHeight) {
        commands += [(container, .addImage(image: image, size: size, caption: caption, sizeFit: sizeFit))]
    }
    
    open func addImagesInRow(_ container: Container = Container.contentLeft, images: [UIImage], captions: [NSAttributedString] = [], spacing: CGFloat = 5.0) {
        commands += [(container, .addImagesInRow(images: images, captions: captions, spacing: spacing))]
    }
    
    // MARK: - Table
    
    open func addTable(_ container: Container = Container.contentLeft, data: [[String]], alignment: [[TableCellAlignment]], relativeColumnWidth: [CGFloat], padding: CGFloat = 0, margin: CGFloat = 0, style: TableStyle = TableStyle()) {
        assert(data.count != 0, "You can't draw an table without rows!")
        assert(data.count == alignment.count, "Data and alignment array must be equal size!")
        for (rowIdx, row) in data.enumerated() {
            assert(row.count == alignment[rowIdx].count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
            assert(row.count == relativeColumnWidth.count, "Data and alignment for row with index \(rowIdx) does not have the same amount!")
        }
        commands += [(container, .addTable(data: data, alignment: alignment, relativeColumnWidth: relativeColumnWidth, padding: padding, margin: margin, style: style))]
    }

    // MARK: - Container
    
    open func addSpace(_ container: Container = Container.contentLeft, space: CGFloat) {
        commands += [(container, .addSpace(space: space))]
    }
    
    open func setIndentation(_ container: Container = Container.contentLeft, indent: CGFloat) {
        commands += [(container, .setIndentation(points: indent))]
    }
    
    open func setAbsoluteOffset(_ container: Container = Container.contentLeft, offset: CGFloat) {
        commands += [(container, .setOffset(points: offset))]
    }
   
    open func createNewPage() {
        commands += [(.contentLeft, .createNewPage())]
    }
}
