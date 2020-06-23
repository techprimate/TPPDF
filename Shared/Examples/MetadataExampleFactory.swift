//
//  MetadataExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 16.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import TPPDF

class MetadataExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)
        // Set document meta data
        document.info.title = "TPPDF Example"
        document.info.subject = "Building a PDF easily"
        document.info.ownerPassword = "Password123"

        // Set spacing of header and footer
        document.layout.space.header = 5
        document.layout.space.footer = 5

        // Just a visual note:

        document.set(font: Font.systemFont(ofSize: 30))
        document.add(text: "Nothing to see here, as it is just meta!")
        
        return [document]
    }
}
