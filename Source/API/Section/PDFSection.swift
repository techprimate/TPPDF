//
//  PDFSection.swift
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
public class PDFSection: PDFDocumentObject {

	/**
	List of section columns.
	*/
	public private(set) var columns: [PDFSectionColumn] = []

	/**
	Horizontal margin between columns in points.
	*/
	public var columnMargin: CGFloat = 10.0

	// MARK: - PUBLIC INITIALIZERS

	/**
	Creates a new section with columns of the given relative widths.

	- parameter columnWidth: Relative column widths. Values are between 0.0 and 1.0 and should sum up to 1.0.
	*/
	public convenience init(columnWidths: [CGFloat]) {
        self.init(columnWidths.map(PDFSectionColumn.init(width:)))
	}

	/**
	Creates a new section with the given columns.
	
	- parameter columns: Preconfigured section columns
	*/
	public init(_ columns: [PDFSectionColumn]) {
		self.columns = columns
	}

    /**
     Creates a new `PDFSection` with the same properties
     */
	internal var copy: PDFSection {
		PDFSection(columns.map(\.copy))
	}
}
