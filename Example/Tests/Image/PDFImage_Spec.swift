//
//  PDFImage_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFImage_Spec: QuickSpec {

    override func spec() {
        describe("PDFImage") {

            let base64String = "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAQABAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMABgYGBgYGCgYGCg4KCgoOEg4ODg4SFxISEhISFxwXFxcXFxccHBwcHBwcHCIiIiIiIicnJycnLCwsLCwsLCwsLP/bAEMBBwcHCwoLEwoKEy4fGh8uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLv/dAAQAAf/aAAwDAQACEQMRAD8A6+iiivxY/Sz/2Q==".data(using: String.Encoding.utf8)!
            let data = Data(base64Encoded: base64String)!
            let image = UIImage(data: data)!

            let caption = PDFSimpleText(text: "EXAMPLE")
            let size = CGSize(width: 100, height: 100)
            let fit = PDFImageSizeFit.height
            let quality: CGFloat = 0.9
            let options: PDFImageOptions = [.resize]

            var pdfImage: PDFImage!

            beforeEach {
                pdfImage = PDFImage(image: image, caption: caption, size: size, sizeFit: fit, quality: quality, options: options)
            }

            context("initializer") {

                it("can be initalized with only an image") {
                    pdfImage = PDFImage(image: image)
                    expect(pdfImage.image) == image
                    expect(pdfImage.caption).to(beNil())
                    expect(pdfImage.sizeFit) == PDFImageSizeFit.widthHeight
                    expect(pdfImage.quality) == 0.85
                    expect(pdfImage.options) == [.resize, .compress]
                }
            }

            context("variables") {

                it("has an image") {
                    expect(pdfImage.image) == image
                }

                it("might have a caption") {
                    expect(pdfImage.caption as? PDFSimpleText) == caption
                }

                it("has a size") {
                    expect(pdfImage.size) == size
                }

                it("has a sizeFit") {
                    expect(pdfImage.sizeFit) == fit
                }

                it("has a quality") {
                    expect(pdfImage.quality) == quality
                }

                it("has options") {
                    expect(pdfImage.options) == options
                }
            }
        }
    }

}
