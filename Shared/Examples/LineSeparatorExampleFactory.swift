//
//  LineSeparatorExampleFactory.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 18.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
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
