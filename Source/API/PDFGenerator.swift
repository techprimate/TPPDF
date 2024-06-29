//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Factory to convert a single `PDFDocument` into a PDF file
 *
 * This is one of the main classes used to interact with the framework.
 *
 * The `PDFGenerator` is a stateful object which should be used exactly once per generator task.
 */
public class PDFGenerator: PDFGeneratorProtocol, CustomStringConvertible {
    // MARK: - INTERNAL VARS

    /// Document which will be converted
    var document: PDFDocument

    /// List of header and footer objects extracted from the document
    var headerFooterObjects: [PDFLocatedRenderObject] = []

    /// Layout which holds current state
    var layout = PDFLayout()

    /// Current page which increments during preparation
    var currentPage: Int = 1

    /// Total page count used for displaying in rendered PDF
    public var totalPages: Int = 1

    /// Layout information used for columns layout
    var columnState = PDFColumnLayoutState()

    /// Group holding elements which will be rendered on each page if not nil
    var masterGroup: PDFGroupObject?

    /// Generator wide padding used for calculations of groups
    var currentPadding = EdgeInsets.zero

    /// Relative value tracking progress
    public let progress = Progress.discreteProgress(totalUnitCount: 3)

    /// Object acts as a delegate during the generation process
    public var delegate: PDFGeneratorDelegate?

    /// Enables the debugging mode, which will render additional visual information on different elements.
    public var debug: Bool = false

    /**
     * Font of each container.
     *
     * These values are used for simple text objects
     */
    lazy var fonts: [PDFContainer: Font] = .init(uniqueKeysWithValues: PDFContainer.allCases.map { container in
        (container, Font.systemFont(ofSize: PDFConstants.defaultFontSize))
    })

    /**
     * Text color of each container.
     *
     * These values are used for simple text objects
     */
    lazy var textColor: [PDFContainer: Color] = .init(uniqueKeysWithValues: PDFContainer.allCases.map { container in
        (container, Color.black)
    })

    // MARK: - PUBLIC INITS

    /**
     * Initializes the generator with a ``PDFDocument```.
     *
     * - Parameter document: The document which will be used to create the PDF document file
     */
    public init(document: PDFDocument) {
        self.document = document

        layout.margin = document.layout.margin
    }

    // MARK: - INTERNAL FUNCS

    /**
     * Resets all temporary values of the generator.
     *
     * This is an internal method used to reset the generator between render passes.
     */
    func resetGenerator() {
        layout.reset()
        columnState.reset()
        currentPage = 1
        fonts = fonts.mapValues { _ in
            Font.systemFont(ofSize: PDFConstants.defaultFontSize)
        }
        textColor = textColor.mapValues { _ in
            Color.black
        }
    }
}
