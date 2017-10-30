//
//  PDFGenerator+Debug.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24/08/2017.
//
//

extension PDFGenerator {
    
    func drawDebugPageOverlay() {
        guard PDFGenerator.debug else {
            return
        }
        
        let debugLineStyle = PDFLineStyle(type: .full, color: UIColor.blue, width: 1.0)
        
        var x = document.layout.margin.left
        PDFGraphics.drawLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: document.layout.height), style: debugLineStyle)
        
        x = document.layout.width - document.layout.margin.right
        PDFGraphics.drawLine(start: CGPoint(x: x, y: 0), end: CGPoint(x: x, y: document.layout.height), style: debugLineStyle)
        
        var y = document.layout.margin.header
        PDFGraphics.drawLine(start: CGPoint(x: 0, y: y), end: CGPoint(x: document.layout.width, y: y), style: debugLineStyle)
        
        y = document.layout.height - document.layout.margin.footer
        PDFGraphics.drawLine(start: CGPoint(x: 0, y: y), end: CGPoint(x: document.layout.width, y: y), style: debugLineStyle)
    }
}
