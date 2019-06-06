//
//  PDFSectionColumn.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.18.
//

/**
 TODO: Documentation
 */
public class PDFSectionColumn: PDFJSONSerializable {

	// MARK: - PUBLIC VARS

	/**
	Holds the relative column width. Value is between 0.0 and 1.0.
	*/
	public private(set) var width: CGFloat

	// MARK: - INTERNAL VARS

	/**
	All objects inside the document and the container they are located in
	*/
	internal var objects: [(PDFSectionColumnContainer, PDFObject)] = []

	// MARK: - PUBLIC INITIALIZERS

	/**
	Creates a new section column with the given relative width.

	- parameter width: Relative column width. Value is between 0.0 and 1.0.
	*/
	public init(width: CGFloat) {
		self.width = width
	}

    /**
     Creates a new `PDFSectionColumn` with the same properties
     */
	internal var copy: PDFSectionColumn {
		return PDFSectionColumn(width: self.width)
	}
}
