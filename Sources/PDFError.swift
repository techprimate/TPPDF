//
//  PDFError.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

public enum PDFError: Error {
    
    case tableContentInvalid(value: Any?)
    case tableIsEmpty
    case tableStructureInvalid(message: String)
    case tableIndexOutOfBounds(index: Int, length: Int)
    
}
