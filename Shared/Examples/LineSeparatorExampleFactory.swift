//
//  LineSeparatorExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import TPPDF

class LineSeparatorExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        document.add(text: "A full separator:")
        document.add(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: Color.darkGray, width: 10))

        document.add(space: 30)

        document.add(text: "A dashed separator:")
        document.add(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .dashed, color: Color.darkGray, width: 10))

        document.add(space: 30)

        document.add(text: "A dotted separator:")
        document.add(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .dotted, color: Color.darkGray, width: 10))

        return [document]
    }
}
