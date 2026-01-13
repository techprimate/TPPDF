//
//  PaginationExampleFactory.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 16.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif
import TPPDF

class PaginationExampleFactory: ExampleFactory {
    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        for i in 1...10 {
            document.add(text: "This is page: \(i)")
            document.createNewPage()
        }

        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure { page, total -> String in
            "\(page) / \(total)"
        }, range: (1, 20), hiddenPages: [3, 7], textAttributes: [
            .font: Font.boldSystemFont(ofSize: 30.0),
            .foregroundColor: Color.blue,
        ])

        return [document]
    }
}
