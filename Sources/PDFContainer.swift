//
//  PDFContainer.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//
//

public enum PDFContainer {
    case none
    case headerLeft, headerCenter, headerRight
    case contentLeft, contentCenter, contentRight
    case footerLeft, footerCenter, footerRight
    
    var opposite: PDFContainer {
        switch self {
        case .headerLeft:
            return .footerLeft
        case .headerCenter:
            return .footerCenter
        case .headerRight:
            return .footerRight
        case .footerLeft:
            return .headerLeft
        case .footerCenter:
            return .headerCenter
        case .footerRight:
            return .headerRight
        default:
            return .none
        }
    }
    
    var isHeader: Bool {
        switch self {
        case .headerLeft, .headerCenter, .headerRight:
            return true
        default:
            return false
        }
    }
    
    var isFooter: Bool {
        switch self {
        case .footerLeft, .footerCenter, .footerRight:
            return true
        default:
            return false
        }
    }
    
    var normalize: PDFContainer {
        switch self {
        case .headerLeft, .headerCenter, .headerRight:
            return .headerLeft
        case .contentLeft, .contentCenter, .contentRight:
            return .contentLeft
        case .footerLeft, .footerCenter, .footerRight:
            return .footerLeft
        case .none:
            return .none
        }
    }
    
    static var all: [PDFContainer] {
        return [
            .headerLeft, .headerCenter, .headerRight,
            .contentLeft, .contentCenter, .contentRight,
            .footerLeft, .footerCenter, .footerRight
        ]
    }
}
