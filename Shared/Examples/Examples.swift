//
//  Examples.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 05.05.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation

enum Examples {

    static var factories: [[(String, ExampleFactory)]] {
        [
            [
                ("List", ListExampleFactory()),
                ("Images", ImageExampleFactory()),
                ("Groups", GroupExampleFactory()),
                ("Table", TableExampleFactory()),
                ("Lines", LineSeparatorExampleFactory()),
                ("Text", TextExampleFactory()),
                ("Table of Contents", TableOfContentsExampleFactory()),
                ("Header & Footer", HeaderFooterExampleFactory()),
                ("Multi Section", MultiSectionExampleFactory()),
                ("Multi Documents", MultipleDocumentsExampleFactory()),
                ("Metadata", MetadataExampleFactory()),
                ("Pagination", PaginationExampleFactory()),
                ("Text Styles", TextStylesExampleFactory()),
                ("External Documents", ExternalDocumentExampleFactory()),
                ("Object Attributes", ObjectAttributesExampleFactory())
            ],
            [
                ("Experiment", ExperimentFactory()),
            ]
        ]
    }
}

