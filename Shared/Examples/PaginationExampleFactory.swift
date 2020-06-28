//
//  PaginationExampleFactory.swift
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

class PaginationExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        for i in 1...10 {
            document.add(text: "This is page: \(i)")
            document.createNewPage()
        }

        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure { (page, total) -> String in
            return "\(page) / \(total)"
            }, range: (1, 20), hiddenPages: [3, 7], textAttributes: [
                .font: Font.boldSystemFont(ofSize: 30.0),
                .foregroundColor: Color.blue
        ])
        
        return [document]
    }
}
