//
//  Container.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 12/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

public enum Container {
    case None
    case HeaderLeft, HeaderCenter, HeaderRight
    case ContentLeft, ContentCenter, ContentRight
    case FooterLeft, FooterCenter, FooterRight
    
    var opposite: Container {
        switch self {
        case .HeaderLeft:
            return .FooterLeft
        case .HeaderCenter:
            return .FooterCenter
        case .HeaderRight:
            return .FooterRight
        case .FooterLeft:
            return .HeaderLeft
        case .FooterCenter:
            return .HeaderCenter
        case .FooterRight:
            return .HeaderRight
        default:
            return .None
        }
    }
    
    var isHeader: Bool {
        switch self {
        case .HeaderLeft, .HeaderCenter, .HeaderRight:
            return true
        default:
            return false
        }
    }
    
    var isFooter: Bool {
        switch self {
        case .FooterLeft, .FooterCenter, .FooterRight:
            return true
        default:
            return false
        }
    }
}

public enum TableCellAlignment {
    case TopLeft, Top, TopRight
    case Left, Center, Right
    case BottomLeft, Bottom, BottomRight
    
    var normalizeVertical: TableCellAlignment {
        switch self {
        case TopLeft, Top, TopRight:
            return Top
        case Left, Center, Right:
            return Center
        case BottomLeft, Bottom, BottomRight:
            return Bottom
        }
    }
    
    var normalizeHorizontal: TableCellAlignment {
        switch self {
        case TopLeft, Left, BottomLeft:
            return Left
        case Top, Center, Bottom:
            return Center
        case TopRight, Right, BottomRight:
            return Right
        }
    }
}