//
//  ImageExampleFactory.swift
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

class ImageExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        // Also you can define a quality in percent between 0.0 and 1.0 which is the JPEG compression quality. This is applied if the option `compress` is set.
        // Use `none` for better and crisp quality of image. You don't need to set the image quality if you set this option.
        // let logoImage = PDFImage(image: Image(named: "Icon.png")!, size: CGSize(width: 150, height: 150), quality: 0.9, options: [.resize, .compress])
        let logoImage = PDFImage(image: Image(named: "Icon.png")!,
                                 size: CGSize(width: 150, height: 150),
                                 options: [.rounded],
                                 cornerRadius: 25)
        document.add(.contentCenter, image: logoImage)

        // Add spacing after image
        document.add(space: 10)
        // Create attributes for captions
        let captionAttributes: [NSAttributedString.Key: AnyObject] = [
            .font: Font.systemFont(ofSize: 15.0),
            .paragraphStyle: { () -> NSMutableParagraphStyle in
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            .foregroundColor: Color(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0),
        ]

        
        // Create an image collage with captions

        let images = [
            [
                PDFImage(image: Image(named: "Image-1.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "In this picture you can see a beautiful waterfall!",
                                                                             attributes: captionAttributes))),
                PDFImage(image: Image(named: "Image-2.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Forrest",
                                                                             attributes: captionAttributes))),
                PDFImage(image: Image(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes)))
            ],
            [
                PDFImage(image: Image(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes))),
                PDFImage(image: Image(named: "Image-4.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Field",
                                                                             attributes: captionAttributes))),
            ]
        ]

        // Add first row of images

        document.add(imagesInRow: images[0], spacing: 10)

        // Add spacing between image rows
        document.add(space: 10)

        // Add second row of images

        document.add(imagesInRow: images[1], spacing: 10)

        // Add many rows of images to test break a page
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)

        // Image and caption should be on same page
        let tallImage = PDFImage(image: Image(named: "Image-4.jpg")!,
                                 size: CGSize(width: 150, height: 800))
        tallImage.caption = PDFSimpleText(text: "Awesome Caption\nLine 2 of awesome Caption")

        // Height should fit
        tallImage.sizeFit = .height

        document.add(.contentCenter, image: tallImage)

        // Just add some text to see page break
        document.add(text: LoremIpsum.get(words: 50))

        return [document]
    }
}
