//
//  PDFGenerator+Lines.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func drawLineSeparator(_ container: Container, style: LineStyle) {
        let y: CGFloat = {
            switch container.normalize {
            case .headerLeft:
                return maxHeaderHeight() + 4
            case .contentLeft:
                return contentHeight + maxHeaderHeight() + headerSpace
            case .footerLeft:
                return contentSize.height + maxHeaderHeight() + headerSpace + footerSpace - 4
            default:
                return 0
            }
        }()
        
        drawLine(start: CGPoint(x: pageMargin + indentation[container.normalize]!, y: y), end: CGPoint(x: contentSize.width - indentation[container.normalize]!, y: y), style: style)
    }
    
    func drawLine(start: CGPoint, end: CGPoint, style: LineStyle) {
        if style.type == .none {
            return
        }
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        path.lineWidth = CGFloat(style.width)
        
        var dashes: [CGFloat] = []
        
        switch style.type {
        case .dashed:
            dashes = [path.lineWidth * 3, path.lineWidth * 3]
            path.lineCapStyle = .butt
            break
        case .dotted:
            dashes = [0, path.lineWidth * 2]
            path.lineCapStyle = .round
            break
        default:
            break
        }
        
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        // Set color
        style.color.setStroke()
        
        path.stroke()
    }
}
