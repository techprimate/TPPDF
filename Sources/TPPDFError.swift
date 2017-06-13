//
//  TPPDFError.swift
//  Pods
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

public enum TPPDFError: Error {
    
    case tableContentInvalid(value: Any?)
    case tableIsEmpty
    case tableStructureInvalid(message: String)
}
