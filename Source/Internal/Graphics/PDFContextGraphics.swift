//
//  PDFContextGraphics.swift
//  
//
//  Created by Philip Niedertscheider on 24.06.20.
//

import Foundation
import CoreGraphics

internal enum PDFContextGraphics {

    internal static func createPDFContext(url: URL, bounds: CGRect, info: PDFInfo) -> CGContext {
        print(#file, #line, "Create PDF Context")
        var mediaBox = bounds
        guard let context = CGContext(url as CFURL, mediaBox: &mediaBox, info.generate() as CFDictionary) else {
            fatalError()
        }
        return context
    }

    internal static func createPDFDataContext(bounds: CGRect, info: PDFInfo) -> (NSMutableData, CGContext) {
        print(#file, #line, "Create PDF Data Context")
        let data = NSMutableData()
        let contextInfo = info.generate()
        var mediaBox = bounds
        guard let consumer = CGDataConsumer(data: data),
            let context = CGContext(consumer: consumer, mediaBox: &mediaBox, contextInfo as CFDictionary) else {
            fatalError()
        }
        return (data, context)
    }

    internal static func closePDFContext(_ context: CGContext) {
        print(#file, #line, "Close PDF Page")
        context.closePDF()
    }

    internal static func beginPDFPage(in context: CGContext, for bounds: CGRect, invertY: Bool = true) {
        print(#file, #line, "Begin PDF Page")
        var mediaBox = bounds
        let boxData = NSData(bytes: &mediaBox, length: MemoryLayout.size(ofValue: mediaBox))
        let pageInfo = [
            kCGPDFContextMediaBox as String: boxData
        ]
        context.beginPDFPage(pageInfo as CFDictionary)

        if invertY {
            context.translateBy(x: 0, y: bounds.height)
            context.scaleBy(x: 1, y: -1)
        }
    }

    internal static func endPDFPage(in context: CGContext) {
        print(#file, #line, "End PDF Page")
        context.endPDFPage()
    }
}
