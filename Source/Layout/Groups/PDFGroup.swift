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
    public var backgroundImage: PDFImage?
    public var backgroundShape: PDFDynamicGeometryShape?

    public var outline: PDFLineStyle

    public var padding: UIEdgeInsets

    // MARK: - INTERNAL VARS

    /**
     All objects inside the document and the container they are located in
     */
    var objects: [(PDFGroupContainer, PDFObject)] = []

    // MARK: - PUBLIC INITIALIZERS

    public init(allowsBreaks: Bool = false,
                backgroundColor: UIColor? = nil,
                backgroundImage: PDFImage? = nil,
                backgroundShape: PDFDynamicGeometryShape? = nil,
                outline: PDFLineStyle = .none,
                padding: UIEdgeInsets = .zero) {
        self.allowsBreaks = allowsBreaks
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.backgroundShape = backgroundShape
        self.outline = outline
        self.padding = padding
    }

    /**
     Creates a new `PDFSectionColumn` with the same properties
     */
    var copy: PDFGroup {
        return PDFGroup(allowsBreaks: self.allowsBreaks,
                        backgroundColor: self.backgroundColor,
                        backgroundImage: self.backgroundImage,
                        backgroundShape: self.backgroundShape,
                        outline: self.outline,
                        padding: self.padding)
    }
}
