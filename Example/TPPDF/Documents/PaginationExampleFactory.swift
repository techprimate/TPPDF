//
//  PaginationExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 16.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF

class PaginationExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)
        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure { (page, total) -> String in
            return "\(page) / \(total)"
            }, range: (1, 20), hiddenPages: [3, 7], textAttributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.green
        ])
        
        return [document]
    }
}
