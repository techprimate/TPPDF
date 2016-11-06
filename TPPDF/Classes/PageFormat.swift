//
//  PageFormat.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 12/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit

public enum PageFormat {
    
    case usLetter
    case a4
    
    var size: CGSize {
        switch self {
        case .usLetter:
            return CGSize(width: 612, height: 762)
        case .a4:
            return CGSize(width: 592, height: 842)
        }
    }
    
    var headerMargin: CGFloat {
        switch self {
        case .usLetter:
            return 30.0
        case .a4:
            return 30.0
        }
    }
    
    var footerMargin: CGFloat {
        switch self {
        case .usLetter:
            return 30.0
        case .a4:
            return 30.0
        }
    }
    
    var margin: CGFloat {
        switch self {
        case .usLetter:
            return 36
        case .a4:
            return 60
        }
    }
    
    var headerSpace: CGFloat {
        switch self {
        case .usLetter:
            return 15
        case .a4:
            return 15
        }
    }
    
    var footerSpace: CGFloat {
        switch self {
        case .usLetter:
            return 15
        case .a4:
            return 15
        }
    }
}
