//
//  PDFInfo.swift
//  TPPDF
//
//  Created by Zheng-Xiang Ke on 2016/12/15.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/// Information saved in PDF file metadata
public class PDFInfo {
    /// Title of document
    public var title: String

    /// Author of document
    public var author: String

    /// Subject of document
    public var subject: String

    /// Keywords of document
    public var keywords: [String]

    /**
     * The owner password of the PDF document
     *
     * If this password is set the document is encrypted; otherwise, the document will not be encrypted.
     */
    public var ownerPassword: String?

    /**
     * The user password of the PDF document
     *
     * If the document is encrypted, then this value will be the user password for the document.
     */
    public var userPassword: String?

    /// Whether the document allows printing when unlocked with the user password.
    public var allowsPrinting: Bool

    /// Whether the document allows copying when unlocked with the user password.
    public var allowsCopying: Bool

    /**
     * Creates a new object to manage the information metadata of a ``PDFDocument``
     *
     * - Parameters:
     *   - title: See ``PDFInfo/title`` for details.
     *   - author: See ``PDFInfo/author`` for details.
     *   - subject: See ``PDFInfo/subject`` for details.
     *   - keywords: See ``PDFInfo/keywords`` for details.
     *   - ownerPassword: See ``PDFInfo/ownerPassword`` for details.
     *   - userPassword: See ``PDFInfo/userPassword`` for details.
     *   - allowsPrinting: See ``PDFInfo/allowsPrinting`` for details.
     *   - allowsCopying: See ``PDFInfo/allowsCopying`` for details.
     */
    public init(
        title: String = "Title",
        author: String = "Author",
        subject: String = "Subject",
        keywords: [String] = ["tppdf", "pdf", "generator"],
        ownerPassword: String? = nil,
        userPassword: String? = nil,
        allowsPrinting: Bool = true,
        allowsCopying: Bool = true
    ) {
        self.title = title
        self.author = author
        self.subject = subject
        self.keywords = keywords
        self.ownerPassword = ownerPassword
        self.userPassword = userPassword
        self.allowsPrinting = allowsPrinting
        self.allowsCopying = allowsCopying
    }

    /**
     * Generates a dictionary of metadata with the following information:
     *
     *  - Title
     *  - Author
     *  - Subject
     *  - Keywords
     *  - Allows Printing
     *  - Allows Copying
     *  - Creator
     *  - Owner Password
     *  - User Password
     */
    func generate() -> [AnyHashable: Any] {
        var documentInfo: [AnyHashable: Any] = [
            kCGPDFContextTitle as String: title,
            kCGPDFContextAuthor as String: author,
            kCGPDFContextSubject as String: subject,
            kCGPDFContextKeywords as String: keywords,
            kCGPDFContextAllowsPrinting as String: allowsPrinting,
            kCGPDFContextAllowsCopying as String: allowsCopying,
        ]

        var creator = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "TPPDF"
        creator += " " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")

        documentInfo[kCGPDFContextCreator as String] = creator

        if let ownerPassword = ownerPassword {
            documentInfo[kCGPDFContextOwnerPassword as String] = ownerPassword
        }

        if let userPassword = userPassword {
            documentInfo[kCGPDFContextUserPassword as String] = userPassword
        }

        return documentInfo
    }
}
