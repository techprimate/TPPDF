//
//  PDFImage_Equatable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 12/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFImage_Equatable_Spec: QuickSpec {

    override func spec() {
        describe("PDFImage") {

            let base64String = "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAQABAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMABgYGBgYGCgYGCg4KCgoOEg4ODg4SFxISEhISFxwXFxcXFxccHBwcHBwcHCIiIiIiIicnJycnLCwsLCwsLCwsLP/bAEMBBwcHCwoLEwoKEy4fGh8uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLv/dAAQAAf/aAAwDAQACEQMRAD8A6+iiivxY/Sz/2Q==".data(using: String.Encoding.utf8)!
            let data = Data(base64Encoded: base64String)!
            let image = UIImage(data: data)!

            let caption = PDFSimpleText(text: "EXAMPLE")
            let size = CGSize(width: 100, height: 100)
            let fit = PDFImageSizeFit.height
            let quality: CGFloat = 0.9

            let pdfImage = PDFImage(image: image, caption: caption, size: size, sizeFit: fit, quality: quality)

            it("is equal") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: caption,
                                             size: size,
                                             sizeFit: fit,
                                             quality: quality)

                expect(pdfImage) == otherPdfImage
            }

            it("is not equal with different image") {
                let otherPdfImage = PDFImage(image: UIImage(),
                                             caption: caption,
                                             size: size,
                                             sizeFit: fit,
                                             quality: quality)

                expect(pdfImage) != otherPdfImage
            }

            it("is not equal with different caption") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: PDFSimpleText(text: "DIFFERENT"),
                                             size: size,
                                             sizeFit: fit,
                                             quality: quality)

                expect(pdfImage) != otherPdfImage
            }

            it("is not equal with one missing caption") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: nil,
                                             size: size,
                                             sizeFit: fit,
                                             quality: quality)

                expect(pdfImage) != otherPdfImage
            }

            it("is not equal with different size") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: caption,
                                             size: CGSize(width: 20, height: 30),
                                             sizeFit: fit,
                                             quality: quality)

                expect(pdfImage) != otherPdfImage
            }

            it("is not equal with different size fit") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: caption,
                                             size: size,
                                             sizeFit: PDFImageSizeFit.width,
                                             quality: quality)

                expect(pdfImage) != otherPdfImage
            }

            it("is not equal with different quality") {
                let otherPdfImage = PDFImage(image: image,
                                             caption: caption,
                                             size: size,
                                             sizeFit: fit,
                                             quality: 0.3)

                expect(pdfImage) != otherPdfImage
            }
        }
    }

}
