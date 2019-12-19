//
//  PDFDocument.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 The main class users interact with.
 This object holds the information about the document and also all PDF objects.

 It is possible to create a JSON representation using the `PDFJSONSerializable` protocol.
 */
public class PDFDocument: CustomStringConvertible, PDFJSONSerializable {

    // MARK: - PUBLIC VARS

    /**
     Holds all layout information
     */
    public var layout: PDFPageLayout

    /**
     Holds all document information
     */
    public var info: PDFInfo = PDFInfo()

    /**
     Holds all pagination information
     */
    public var pagination = PDFPagination()

    /**
     Holds strong references to all text styles
     */
    public var styles: [PDFTextStyle] = []

    // MARK: - INTERNAL VARS

    /**
     All objects inside the document and the container they are located in
     */
    internal var objects: [(PDFContainer, PDFRenderObject)] = []

    /**
     TODO: Documentation
     */
    internal var masterGroup: PDFGroupObject?

    // MARK: - PUBLIC INITIALIZERS

    /**
     Creates a new document with the given layout

     - parameter layout: Layout information for document
     */
    public init(layout: PDFPageLayout) {
        self.layout = layout
    }

    /**
     Creates a new document with a predefined `PDFPageFormat`

     - parameter layout: Predefined page formats
     */
    public init(format: PDFPageFormat) {
        self.layout = format.layout
    }

}
