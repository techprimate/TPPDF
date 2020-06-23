//
//  PDFContextGraphics.swift
//  
//
//  Created by Philip Niedertscheider on 24.06.20.
//

import Foundation
import CoreGraphics

enum PDFContextGraphics {

    static func createPDFContext(url: URL, bounds: CGRect, info: PDFInfo) -> CGContext {
        print(#file, #line, "Create PDF Context")
        var mediaBox = bounds
        guard let context = CGContext(url as CFURL, mediaBox: &mediaBox, info.generate() as CFDictionary) else {
            fatalError()
        }
        return context
    }

    static func createPDFDataContext(bounds: CGRect, info: PDFInfo) -> (NSMutableData, CGContext) {
        print(#file, #line, "Create PDF Data Context")
        #if os(iOS)
        UIGraphicsBeginPDFContextToData(data, document.layout.bounds, (info ?? document.info).generate())
        #elseif os(macOS)
        let data = NSMutableData()
        var mediaBox = bounds
        guard let consumer = CGDataConsumer(data: data),
            let context = CGContext(consumer: consumer, mediaBox: &mediaBox, info.generate() as CFDictionary) else {
            fatalError()
        }
        return (data, context)
        #endif
    }

    static func closePDFContext(_ context: CGContext) {
        print(#file, #line, "Close PDF Page")
        #if os(iOS)
        UIGraphicsEndPDFContext()
        #elseif os(macOS)
        context.closePDF()
        #endif
    }

    static func beginPDFPage(in context: CGContext, for bounds: CGRect) {
        print(#file, #line, "Begin PDF Page")
        #if os(iOS)
        UIGraphicsBeginPDFPageWithInfo(bounds, nil)
        #elseif os(macOS)
        var mediaBox = bounds
        let boxData = NSData(bytes: &mediaBox, length: MemoryLayout.size(ofValue: mediaBox))
        let pageInfo = [ kCGPDFContextMediaBox as String : boxData ]
        context.beginPDFPage(pageInfo as CFDictionary)
        context.translateBy(x: 0, y: bounds.height)
        context.scaleBy(x: 1, y: -1)
        #endif
    }

    static func endPDFPage(in context: CGContext) {
        print(#file, #line, "End PDF Page")
        context.endPDFPage()
    }
}
