//
//  FileManager+TemporaryFiles.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.12.19.
//

import Foundation

extension FileManager {

    /**
     Creates a guaranteed temporary PDF file URL with the given name

     - Parameter name: name of file, if it does not end with `pdf`, `pdf` will be appended

     - Returns: URL to a temporary file
     */
    internal static func generateTemporaryOutputURL(for name: String) -> URL {
        let normalisedName = name.lowercased().hasSuffix(".pdf") ? name : (name + ".pdf")
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(normalisedName)
    }
}
