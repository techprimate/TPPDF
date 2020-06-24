//
//  PDFView+SwiftUI.swift
//  Example
//
//  Created by Philip Niedertscheider on 23.06.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import PDFKit
import SwiftUI

#if os(macOS)
import AppKit

struct PDFKitRepresentedView: NSViewRepresentable {

    var url: URL?

    init(url: URL?) {
        self.url = url
    }

    func makeNSView(context: NSViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.NSViewType {
        let pdfView = PDFView()
        if let url = self.url {
            pdfView.document = PDFDocument(url: url)
        } else {
            pdfView.document = nil
        }
        return pdfView
    }

    func updateNSView(_ nsView: NSView, context: NSViewRepresentableContext<PDFKitRepresentedView>) {
        guard let pdfView = nsView as? PDFView else {
            return
        }
        if let url = self.url {
            pdfView.document = PDFDocument(url: url)
        } else {
            pdfView.document = nil
        }
    }
}

#elseif os(iOS)
import UIKit

struct PDFKitRepresentedView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: UIViewRepresentableContext<PDFKitRepresentedView>) -> PDFKitRepresentedView.UIViewType {
        // Create a `PDFView` and set its `PDFDocument`.
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: self.url)
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFKitRepresentedView>) {}
}

#endif
