//
//  PDFTableOfContent.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 28.05.19.
//

/// Internal utility type alias for weak references to document wide text styles
typealias WeakPDFTextStyleRef = WeakRef<PDFTextStyle>

/**
  Creates a table of content for the given list of render objects.

  The given list of `styles` are used to identify which ``PDFAttributedTextObject`` should be considered as "headers"
  and therefore be in the table of contents.

  Furthermore, the index of the style in the list of `styles` is used as the nesting level.

  Looking at the following example document, there are 3 levels of headers defined:
  - **Title**
  - **Heading 1**
  - **Heading 2**

  Any other text which is not using these styles, should be considered body content text.

      let document = PDFDocument(format: .a4)

      // Define document wide styles
      let titleStyle = document.add(style: PDFTextStyle(name: "Title"))
      let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1"))
      let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2"))

      // Add a string using the title style
      document.add(textObject: PDFSimpleText(text: "TPPDF", style: titleStyle))

      // Add a table of content, the content will be calculated based on the usages of the styles
      document.add(text: "Table of Contents")
      document.add(tableOfContent: PDFTableOfContent(styles: [
          headingStyle1,
          headingStyle2,
      ], symbol: .none))

      // Add headline with extra spacing
      document.add(textObject: PDFSimpleText(text: "1. Introduction", style: headingStyle1))
      document.add(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")

      document.add(textObject: PDFSimpleText(text: "2. Images", style: headingStyle1))
      document.add(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")

      document.add(textObject: PDFSimpleText(text: "2.1 Special Images", style: headingStyle2))
      document.add(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")

      document.add(textObject: PDFSimpleText(text: "3. Tables", style: headingStyle1))
      document.add(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.")

  The output of the table of contents nested lists will look like this:

 - 1. Introduction
  - 2. Images
     - 2.1 Special Images
  - 3. Tables

  */
public class PDFTableOfContent: PDFDocumentObject {
    /// List of weak references to ``PDFTextStyle`` used internally to render the Table Of Contents
    var styles: [WeakPDFTextStyleRef]

    /**
     Symbol used in the ``PDFList`` after converting the table of contents.

     See ``PDFListItem/symbol`` for further information
     */
    public var symbol: PDFListItemSymbol

    /**
     Creates a new Table Of Contents by selecting render objects matching the given `styles`

     - Parameter styles: List of ``PDFTextStyle`` to select the relevant ``PDFAttributedText`` objects in the document
     - Parameter symbol: Symbol used for the resulting `PDFList`
     */
    public init(styles: [PDFTextStyle], symbol: PDFListItemSymbol) {
        self.styles = styles.map(WeakPDFTextStyleRef.init(value:))
        self.symbol = symbol
    }

    /// nodoc
    var copy: PDFTableOfContent {
        let object = PDFTableOfContent(styles: [], symbol: symbol)
        object.styles = Array(styles)
        return object
    }
}
