//
//  PDFInfo.swift
//  TPPDF
//
//  Created by Zheng-Xiang Ke on 15.12.2016.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
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
     * Creator of document.
     *
     * When `nil` (the default), this falls back to the host app's `CFBundleName` plus its
     * `CFBundleShortVersionString`, matching TPPDF's historical behavior. Set this explicitly
     * to control the PDF's "Creator" metadata field independently of the app's bundle name —
     * for example, when the bundle name differs from the app's user-facing brand name.
     */
    public var creator: String?

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
     *   - creator: See ``PDFInfo/creator`` for details.
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
        creator: String? = nil,
        ownerPassword: String? = nil,
        userPassword: String? = nil,
        allowsPrinting: Bool = true,
        allowsCopying: Bool = true
    ) {
        self.title = title
        self.author = author
        self.subject = subject
        self.keywords = keywords
        self.creator = creator
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

        let resolvedCreator: String
        if let creator {
            resolvedCreator = creator
        } else {
            let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "TPPDF"
            let bundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
            resolvedCreator = "\(bundleName) \(bundleVersion)"
        }

        documentInfo[kCGPDFContextCreator as String] = resolvedCreator

        if let ownerPassword = ownerPassword {
            documentInfo[kCGPDFContextOwnerPassword as String] = ownerPassword
        }

        if let userPassword = userPassword {
            documentInfo[kCGPDFContextUserPassword as String] = userPassword
        }

        return documentInfo
    }
}
