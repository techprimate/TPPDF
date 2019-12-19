//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

import UIKit

/**
 Factory which converts a document into a PDF file
 */
public class PDFGenerator: PDFGeneratorProtocol, CustomStringConvertible {
    
    // MARK: - INTERNAL VARS

    /**
     Document which will be converted
     */
    internal var document: PDFDocument

    /**
     List of header and footer objects extracted from the document
     */
    internal var headerFooterObjects: [(PDFContainer, PDFRenderObject)] = []

    /**
     Layout which holds current state
     */
    internal var layout = PDFLayout()

    /**
     Current page which increments during preparation
     */
    internal var currentPage: Int = 1

    /**
     Total page count used for displaying in rendered PDF
     */
    public var totalPages: Int = 1

    /**
     Layout information used for columns layout
     */
    internal var columnState = PDFColumnLayoutState()

    /**
     TODO: Documentation
     */
    internal var masterGroup: PDFGroupObject?

    /**
     TODO: Documentation
     */
    internal var currentPadding = UIEdgeInsets.zero

    /**
     Relative value tracking progress
     */
    public let progress = Progress.discreteProgress(totalUnitCount: 3)

    /**
     Font of each container.
     These values are used for simple text objects
     */
    internal lazy var fonts: [PDFContainer: UIFont] = {
        var defaults = [PDFContainer: UIFont]()
        for container in PDFContainer.allCases {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()

    /**
     Enables debugging on all generator instance
     */
    public var debug: Bool = false

    /**
     Text color of each container.
     These values are used for simple text objects
     */
    internal lazy var textColor: [PDFContainer: UIColor] = {
        var defaults = [PDFContainer: UIColor]()
        for container in PDFContainer.allCases {
            defaults[container] = UIColor.black
        }
        return defaults
    }()

    // MARK: - PUBLIC INITS

    /**
     Initializes the generator with a document.

     - parameter document: The document which will be converted
     */
    public init(document: PDFDocument) {
        self.document = document

        layout.margin = document.layout.margin
    }

    // MARK: - INTERNAL FUNCS

    /**
     Resets the generator
     */
    internal func resetGenerator() {
        layout.reset()
        columnState.reset()
        currentPage = 1
    }
}
