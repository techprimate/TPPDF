//
//  DocumentSettingsExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 22.05.19.
//  Copyright © 2026-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif
import TPPDF

class DocumentSettingsExampleFactory: ExampleFactory {
    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)
        document.background.color = .green

        document.set(textColor: .white)
        document.set(font: .systemFont(ofSize: 30, weight: .bold))
        document.add(text: "Just some sample text...")

        document.createNewPage()

        document.add(text: "Just some more sample text...")

        return [document]
    }
}
