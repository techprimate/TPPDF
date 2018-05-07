//
//  PDFGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

/**
 Factory which converts a document into a PDF file
 */
public class PDFGenerator {

    // MARK: - INTERNAL VARS

    /**
     Document which will be converted
     */
    var document: PDFDocument

    /**
     List of header and footer objects extracted from the document
     */
    var headerFooterObjects: [(PDFContainer, PDFObject)] = []

    /**
     Layout which holds current state
     */
    var layout = PDFLayout()

    /**
     Current page which increments during preparation
     */
    var currentPage: Int = 1

    /**
     Total page count used for displaying in rendered PDF
     */
    var totalPages: Int = 1

    var progressValue: CGFloat = 0

    /**
     Font of each container.
     These values are used for simple text objects
     */
    lazy var fonts: [PDFContainer: UIFont] = {
        var defaults = [PDFContainer: UIFont]()
        for container in PDFContainer.all + [PDFContainer.none] {
            defaults[container] = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        }
        return defaults
    }()

    /**
     Enables debugging on all generator instance
     */
    var debug: Bool = false

    /**
     Text color of each container.
     These values are used for simple text objects
     */
    lazy var textColor: [PDFContainer: UIColor] = {
        var defaults = [PDFContainer: UIColor]()
        for container in PDFContainer.all + [PDFContainer.none] {
            defaults[container] = UIColor.black
        }
        return defaults
    }()

    // MARK: - INTERNAL INITS

    /**
     Initializes the generator with a document.

     - parameter document: The document which will be converted
     */
    init(document: PDFDocument) {
        self.document = document
    }

    // MARK: - INTERNAL FUNCS

    /**
     Resets the generator
     */
    func resetGenerator() {
        layout.reset()
        currentPage = 1
    }

}
