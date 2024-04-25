//
//  PDFGeneratorProtocol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 18.12.19.
//

import Foundation

/// Protocol including all public methods and accessors available for generating documents
public protocol PDFGeneratorProtocol: AnyObject {
    /// Instance of  ``Progress`` used to track and control the multi-document generation
    var progress: Progress { get }

    /// Flag to enable or disable the debug overlay
    var debug: Bool { get set }

    /**
     * Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.
     *
     * Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.
     *
     * - Parameter filename: Name of output file, `.pdf` will be appended if not given
     * - Parameter info: Instance of `PDFInfo` with meta file information, defaults to default initializer of `PDFInfo`
     *
     * - Returns: Temporary URL to the output file
     *
     * - Throws: Exception, if something went wrong
     */
    func generateURL(filename: String, info: PDFInfo?) throws -> URL

    /**
     * Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.
     *
     * Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.
     *
     * - Parameter filename: Name of output file, `.pdf` will be appended if not given
     *
     * - Returns: Temporary URL to the output file
     *
     * - Throws: Exception, if something went wrong
     */
    func generateURL(filename: String) throws -> URL

    /**
     * Creates a file  at the given file URL,  generates the PDF context data and writes the result idata nto the file.
     *
     * - Parameter target: URL of output file,
     * - Parameter info: Instance of `PDFInfo` with meta file information
     *
     * - Throws: Exception, if something went wrong
     */
    func generate(to url: URL, info: PDFInfo?) throws

    /**
     * Creates a file  at the given file URL,  generates the PDF context data and writes the result idata nto the file.
     *
     * - Parameter target: URL of output file,
     *
     * - Throws: Exception, if something went wrong
     */
    func generate(to url: URL) throws

    /**
     * Generates and returns the PDF context data.
     *
     * - Parameter info: Instance of `PDFInfo` with meta file information
     *
     * - Throws: Exception, if something went wrong
     *
     * - Returns:PDF data
     */
    func generateData(info: PDFInfo?) throws -> Data

    /**
     * Generates and returns the PDF context data.
     *
     * - Throws: Exception, if something went wrong
     *
     * - Returns:PDF data
     */
    func generateData() throws -> Data
}

public extension PDFGeneratorProtocol {
    /**
     * Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.
     *
     * Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.
     *
     * - Parameter filename: Name of output file, `.pdf` will be appended if not given
     * - Parameter info: Instance of `PDFInfo` with meta file information, defaults to default initializer of `PDFInfo`
     *
     * - Returns: Temporary URL to the output file
     *
     * - Throws: Exception, if something went wrong
     */
    func generateURL(filename: String, info: PDFInfo?) throws -> URL {
        let url = FileManager.generateTemporaryOutputURL(for: filename)
        try generate(to: url, info: info)
        return url
    }
}
