//
//  PDFContextGraphics.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24.06.20.
//

import CoreGraphics
import Foundation

enum PDFContextGraphics {
    static func createBitmapContext(size: CGSize) -> CGContext? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * Int(size.width)
        let rawData = malloc(Int(size.height) * bytesPerRow)
        let bitsPerComponent = 8
        return CGContext(
            data: rawData,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
    }

    static func getImage(from context: CGContext, size: CGSize) -> Image? {
        guard let cgImage = context.makeImage() else {
            return nil
        }
        #if os(macOS)
            return Image(cgImage: cgImage, size: size)
        #elseif os(iOS) || os(visionOS)
            return Image(cgImage: cgImage)
        #endif
    }

    static func createPDFContext(url: URL, bounds: CGRect, info: PDFInfo) -> PDFContext {
        var mediaBox = bounds
        guard let context = CGContext(url as CFURL, mediaBox: &mediaBox, info.generate() as CFDictionary) else {
            fatalError("Failed to create PDF rendering context for URL")
        }
        return PDFContext(cgContext: context)
    }

    static func createPDFDataContext(bounds: CGRect, info: PDFInfo) -> (NSMutableData, PDFContext) {
        let data = NSMutableData()
        let contextInfo = info.generate()
        var mediaBox = bounds
        guard let consumer = CGDataConsumer(data: data),
              let context = CGContext(consumer: consumer, mediaBox: &mediaBox, contextInfo as CFDictionary) else {
            fatalError("Failed to create PDF rendering context")
        }
        return (data, PDFContext(cgContext: context))
    }

    static func closePDFContext(_ context: PDFContext) {
        context.closePDF()
    }

    static func beginPDFPage(in context: PDFContext, for bounds: CGRect, flipped: Bool = true) {
        var mediaBox = bounds
        let boxData = NSData(bytes: &mediaBox, length: MemoryLayout.size(ofValue: mediaBox))
        let pageInfo = [
            kCGPDFContextMediaBox as String: boxData,
        ]
        context.beginPDFPage(pageInfo as CFDictionary)

        if flipped {
            context.translateBy(x: 0, y: bounds.height)
            context.scaleBy(x: 1, y: -1)
        }
    }

    static func endPDFPage(in context: PDFContext) {
        context.endPDFPage()
    }
}
