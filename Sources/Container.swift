//
//  Container.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/16.
//
//

public enum Container {
    case none
    case headerLeft, headerCenter, headerRight
    case contentLeft, contentCenter, contentRight
    case footerLeft, footerCenter, footerRight
    
    var opposite: Container {
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
    
    var normalize: Container {
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
    
    static var all: [Container] {
        return [
            .headerLeft, .headerCenter, .headerRight,
            .contentLeft, .contentCenter, .contentRight,
            .footerLeft, .footerCenter, .footerRight
        ]
    }
}

public enum TableCellAlignment {
    case topLeft, top, topRight
    case left, center, right
    case bottomLeft, bottom, bottomRight
    
    var normalizeVertical: TableCellAlignment {
        switch self {
        case .topLeft, .top, .topRight:
            return .top
        case .left, .center, .right:
            return .center
        case .bottomLeft, .bottom, .bottomRight:
            return .bottom
        }
    }
    
    var normalizeHorizontal: TableCellAlignment {
        switch self {
        case .topLeft, .left, .bottomLeft:
            return .left
        case .top, .center, .bottom:
            return .center
        case .topRight, .right, .bottomRight:
            return .right
        }
    }
}

public enum ImageSizeFit {
    case width, height, widthHeight
}
