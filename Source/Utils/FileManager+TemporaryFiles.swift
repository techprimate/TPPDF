//
//  FileManager+TemporaryFiles.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.12.19.
//

import Foundation

extension FileManager {
   
    internal static func generateTemporaryOutputURL(for name: String) -> URL {
        let normalisedName = name.lowercased().hasSuffix(".pdf") ? name : (name + ".pdf")
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(normalisedName)
    }
}
