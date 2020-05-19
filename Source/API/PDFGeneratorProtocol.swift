//
//  PDFGeneratorProtocol.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 18.12.19.
//

import Foundation

/**
 Protocol including all public methods and accessors available for generating documents
 */
public protocol PDFGeneratorProtocol: class {

    /**
     Instance of  `Progress` used to track and control the multi-document generation
     */
    var progress: Progress { get }

    /**
     Flag to enable or disable the debug overlay
     */
    var debug: Bool { get set }

    /**
     Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.

     Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.

     - parameter filename: Name of output file, `.pdf` will be appended if not given
     - parameter info: Instance of `PDFInfo` with meta file information, defaults to default initialiser of `PDFInfo`

     - returns: Temporary URL to the output file

     - throws: Exception, if something went wrong
     */
    func generateURL(filename: String, info: PDFInfo?) throws -> URL

    /**
     Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.

     Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.

     - parameter filename: Name of output file, `.pdf` will be appended if not given

     - returns: Temporary URL to the output file

     - throws: Exception, if something went wrong
     */
    func generateURL(filename: String) throws -> URL

    /**
     Creates a file  at the given file URL,  generates the PDF context data and writes the result idata nto the file.

     - parameter target: URL of output file,
     - parameter info: Instance of `PDFInfo` with meta file information

     - throws: Exception, if something went wrong
     */
    func generate(to url: URL, info: PDFInfo?) throws

    /**
     Creates a file  at the given file URL,  generates the PDF context data and writes the result idata nto the file.

     - parameter target: URL of output file,

     - throws: Exception, if something went wrong
     */
    func generate(to url: URL) throws

    /**
     Generates and returns the PDF context data.

     - parameter info: Instance of `PDFInfo` with meta file information

     - throws: Exception, if something went wrong

     - returns:PDF data
     */
    func generateData(info: PDFInfo?) throws -> Data

    /**
     Generates and returns the PDF context data.

     - throws: Exception, if something went wrong

     - returns:PDF data
     */
    func generateData() throws -> Data

}

extension PDFGeneratorProtocol {

    /**
     Creates a file in a guaranteed temporary folder with the given filename, generates the PDF context data and writes the result into the file.

     Keep in mind, the output file is in a temporary folder of the OS and should be persisted by your own logic.

     - parameter filename: Name of output file, `.pdf` will be appended if not given
     - parameter info: Instance of `PDFInfo` with meta file information, defaults to default initialiser of `PDFInfo`

     - returns: Temporary URL to the output file

     - throws: Exception, if something went wrong
     */
    public func generateURL(filename: String, info: PDFInfo?) throws -> URL {
        let url = FileManager.generateTemporaryOutputURL(for: filename)
        try generate(to: url, info: info)
        return url
    }
}
