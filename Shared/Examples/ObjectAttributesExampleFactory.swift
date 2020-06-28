//
//  ObjectAttributesExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 19.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import TPPDF

class ObjectAttributesExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        let logoImage = PDFImage(image: Image(named: "Icon.png")!, size: CGSize(width: 150, height: 150))
        logoImage.add(attribute: .link(url: URL(string: "https://www.github.com/techprimate/TPPDF")!))
        document.add(.contentCenter, image: logoImage)

        let veryLongLink = "This is a very long link i guess"
        let pattern = "Word Link Word - " + veryLongLink + " - "
        let count = 20
        let text = (0..<count).reduce("", { (prev, _) in prev + pattern})
        let attributedString = NSMutableAttributedString(string: text)
        for i in 0..<20 {
            attributedString.addAttribute(.link,
                                          value: "https://www.github.com/techprimate/TPPDF",
                                          range: NSRange(location: pattern.count * i + 5, length: 4))

            attributedString.addAttribute(.link,
                                          value: "https://www.github.com/techprimate/TPPDF",
                                          range: NSRange(location: pattern.count * i + 17, length: veryLongLink.count))
        }
        document.add(attributedText: attributedString)
        
        return [document]
    }
}
