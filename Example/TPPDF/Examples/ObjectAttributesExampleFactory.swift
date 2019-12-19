//
//  ObjectAttributesExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 19.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

import Foundation
import TPPDF

class ObjectAttributesExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        let logoImage = PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150))
        logoImage.add(attribute: .link(url: URL(string: "https://www.github.com/techprimate/TPPDF")!))
        document.add(.contentCenter, image: logoImage)

        return [document]
    }
}
