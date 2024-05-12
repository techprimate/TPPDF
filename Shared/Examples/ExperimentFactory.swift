//
//  ExperimentFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 12.12.19.
//  Copyright © 2022 techprimate GmbH. All rights reserved.
//

import Foundation
import TPPDF
import UIKit

class ExperimentFactory: ExampleFactory {
    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .b5)
        document.add(.contentCenter, text: "Some Test Name")
        let images = [
            "file:///Users/Philip/Downloads/test_images/0000.jpg",
            "file:///Users/Philip/Downloads/test_images/0001.jpg",
            "file:///Users/Philip/Downloads/test_images/0002.jpg",
            "file:///Users/Philip/Downloads/test_images/0003.jpg",
            "file:///Users/Philip/Downloads/test_images/0004.jpg",
            "file:///Users/Philip/Downloads/test_images/0005.jpg",
            "file:///Users/Philip/Downloads/test_images/0006.jpg",
            "file:///Users/Philip/Downloads/test_images/0007.jpg",
            "file:///Users/Philip/Downloads/test_images/0008.jpg",
            "file:///Users/Philip/Downloads/test_images/0009.jpg",
        ]
        images[0..<images.count].compactMap({ imageFileUrl -> PDFImage? in
            guard let imageURL = URL(string: imageFileUrl),
                  let image = UIImage(contentsOfFile: imageURL.path(percentEncoded: false)),
                  image.size != .zero
            else {
                return nil
            }

            let pdfImage = PDFImage(image: image)
            return pdfImage
        }).forEach({ pdfImage in
            document.add(image: pdfImage)
        })
        return [document]
    }
}
