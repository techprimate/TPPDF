//
//  PDFGroup.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

import Foundation

public class PDFGroup: PDFJSONSerializable {

    // MARK: - PUBLIC VARS

    public var allowsBreaks: Bool

    public var backgroundColor: UIColor?

    // MARK: - INTERNAL VARS

    /**
     All objects inside the document and the container they are located in
     */
    var objects: [(PDFGroupContainer, PDFObject)] = []

    // MARK: - PUBLIC INITIALIZERS

    public init(allowsBreaks: Bool = false, backgroundColor: UIColor? = nil) {
        self.allowsBreaks = allowsBreaks
        self.backgroundColor = backgroundColor
    }

    /**
     Creates a new `PDFSectionColumn` with the same properties
     */
    var copy: PDFGroup {
        return PDFGroup(allowsBreaks: self.allowsBreaks, backgroundColor: self.backgroundColor)
    }
}
