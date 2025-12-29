//
//  PDFView+SwiftUI.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.06.2020.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import PDFKit
import SwiftUI

#if os(iOS)
import UIKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context _: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }

    func updateUIView(_: UIView, context _: UIViewRepresentableContext<PDFKitRepresentedView>) {}
}
#else
import AppKit

struct PDFKitRepresentedView: NSViewRepresentable {
    var url: URL?

    func makeNSView(context _: NSViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.NSViewType {
        let pdfView = PDFView()
        if let url = url {
            pdfView.document = PDFDocument(url: url)
        } else {
            pdfView.document = nil
        }
        return pdfView
    }

    func updateNSView(_ nsView: NSView, context _: NSViewRepresentableContext<PDFKitRepresentedView>) {
        guard let pdfView = nsView as? PDFView else {
            return
        }
        if let url = url {
            pdfView.document = PDFDocument(url: url)
        } else {
            pdfView.document = nil
        }
    }
}
#endif
