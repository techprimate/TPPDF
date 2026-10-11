//
//  PDFView+SwiftUI.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.06.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import PDFKit
import SwiftUI

#if os(iOS)
struct PDFKitRepresentedView: UIViewRepresentable {
    var url: URL?

    func makeUIView(context _: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context _: Context) {
        pdfView.document = url.flatMap { PDFDocument(url: $0) }
    }
}
#elseif os(macOS)
struct PDFKitRepresentedView: NSViewRepresentable {
    var url: URL?

    func makeNSView(context _: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }

    func updateNSView(_ pdfView: PDFView, context _: Context) {
        pdfView.document = url.flatMap { PDFDocument(url: $0) }
    }
}
#endif
