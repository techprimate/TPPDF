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

/**
 TODO: Documentation
 */
public class PDFSectionColumn: PDFDocumentObject {

	// MARK: - PUBLIC VARS

	/**
	Holds the relative column width. Value is between 0.0 and 1.0.
	*/
	public private(set) var width: CGFloat

    /**
    Background color of this section
     */
    public var backgroundColor: Color?

	// MARK: - INTERNAL VARS

	/**
	All objects inside the document and the container they are located in
	*/
	internal var objects: [(PDFSectionColumnContainer, PDFRenderObject)] = []

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
		PDFSectionColumn(width: self.width)
	}
}
