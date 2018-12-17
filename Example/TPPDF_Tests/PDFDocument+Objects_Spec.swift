//
//  PDFDocument+Objects_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 09/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFDocument_Objects_Spec: QuickSpec {

    override func spec() {
        describe("PDFDocument") {

            context("Objects") {

                var document: PDFDocument!

                beforeEach {
                    document = PDFDocument(format: .a4)
                }

                context("spacing") {

                    let value: CGFloat = 20

                    it("is possible to add into default container") {
                        document.addSpace(space: value)
                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let spaceObject = document.objects[0].1 as? PDFSpaceObject
                        expect(spaceObject?.space) == value
                    }

                    it("is possible to add into specific container") {
                        document.addSpace(.footerLeft, space: value)
                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.footerLeft

                        let spaceObject = document.objects[0].1 as? PDFSpaceObject
                        expect(spaceObject?.space) == value
                    }
                }

                context("line separator") {

                    let style = PDFLineStyle(type: .dotted, color: .red, width: 10)

                    it("is possible to add into default container") {
                        document.addLineSeparator(style: style)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let separatorObject = document.objects[0].1 as? PDFLineSeparatorObject
                        expect(separatorObject?.style) == style
                    }

                    it("is possible to add into specific container") {
                        document.addLineSeparator(.headerRight, style: style)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let separatorObject = document.objects[0].1 as? PDFLineSeparatorObject
                        expect(separatorObject?.style) == style
                    }
                }

                context("image") {

                    let base64String = "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAaADAAQAAAABAAAAAQAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAQABAwEiAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMABgYGBgYGCgYGCg4KCgoOEg4ODg4SFxISEhISFxwXFxcXFxccHBwcHBwcHCIiIiIiIicnJycnLCwsLCwsLCwsLP/bAEMBBwcHCwoLEwoKEy4fGh8uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLv/dAAQAAf/aAAwDAQACEQMRAD8A6+iiivxY/Sz/2Q==".data(using: String.Encoding.utf8)!
                    let data = Data(base64Encoded: base64String)!
                    let image = UIImage(data: data)!

                    let pdfImage = PDFImage(image: image)

                    it("is possible to add an image to the default container") {
                        document.addImage(image: pdfImage)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let separatorObject = document.objects[0].1 as? PDFImageObject
                        expect(separatorObject?.image) == pdfImage
                    }

                    it("is possible to add an image to a specific container") {
                        document.addImage(.headerRight, image: pdfImage)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let separatorObject = document.objects[0].1 as? PDFImageObject
                        expect(separatorObject?.image) == pdfImage
                    }

                    context("rows") {

                        let images = [pdfImage, pdfImage, pdfImage]
                        let spacing: CGFloat = 10.0

                        it("is possible to add an image row to the default container") {
                            document.addImage(image: pdfImage)

                            expect(document.objects).to(haveCount(1))
                            expect(document.objects[0].0) == PDFContainer.contentLeft

                            let separatorObject = document.objects[0].1 as? PDFImageObject
                            expect(separatorObject?.image) == pdfImage
                        }

                        it("is possible to add an image row with a specific spacing to a specific container") {
                            document.addImagesInRow(.headerRight, images: images, spacing: spacing)

                            expect(document.objects).to(haveCount(1))
                            expect(document.objects[0].0) == PDFContainer.headerRight

                            let separatorObject = document.objects[0].1 as? PDFImageRowObject
                            expect(separatorObject?.images) == images
                            expect(separatorObject?.spacing) == spacing
                        }
                    }
                }

                context("image row") {

                }

                context("simple text") {

                    let text = "EXAMPLE"
                    let spacing: CGFloat = 2.5

                    it("is possible to add a text with default spacing to the default container") {
                        document.addText(text: text)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let separatorObject = document.objects[0].1 as? PDFAttributedTextObject
                        expect(separatorObject?.attributedText).to(beNil())
                        expect(separatorObject?.simpleText?.text) == text
                    }

                    it("is possible to add a text with specific spacing to a specific container") {
                        document.addText(.headerRight, text: text, lineSpacing: spacing)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let separatorObject = document.objects[0].1 as? PDFAttributedTextObject
                        expect(separatorObject?.attributedText).to(beNil())
                        expect(separatorObject?.simpleText?.text) == text
                        expect(separatorObject?.simpleText?.spacing) == spacing
                    }
                }

                context("attributed text") {

                    let text = NSAttributedString(string: "EXAMPLE")

                    it("is possible to add an attributed text to the default container") {
                        document.addAttributedText(text: text)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let separatorObject = document.objects[0].1 as? PDFAttributedTextObject
                        expect(separatorObject?.attributedText?.text) == text
                        expect(separatorObject?.simpleText).to(beNil())
                    }

                    it("is possible to add an attributed text to a specific container") {
                        document.addAttributedText(.headerRight, text: text)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let separatorObject = document.objects[0].1 as? PDFAttributedTextObject
                        expect(separatorObject?.attributedText?.text) == text
                        expect(separatorObject?.simpleText).to(beNil())
                    }
                }

                context("text font") {

                    let font = UIFont.systemFont(ofSize: 20, weight: .bold)

                    it("is possible to set the text color of the default container") {
                        document.setFont(font: font)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFFontObject
                        expect(object?.font) == font
                    }

                    it("is possible to set the text color a specific container") {
                        document.setFont(.headerRight, font: font)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFFontObject
                        expect(object?.font) == font
                    }

                    it("is possible to reset the text color of the default container") {
                        document.resetFont()

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFFontObject
                        expect(object?.font) == UIFont.systemFont(ofSize: UIFont.systemFontSize)
                    }

                    it("is possible to reset the text color a specific container") {
                        document.resetFont(.headerRight)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFFontObject
                        expect(object?.font) == UIFont.systemFont(ofSize: UIFont.systemFontSize)
                    }
                }

                context("text color") {

                    let color = UIColor.orange

                    it("is possible to set the text color of the default container") {
                        document.setTextColor(color: color)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFTextColorObject
                        expect(object?.color) == color
                    }

                    it("is possible to set the text color a specific container") {
                        document.setTextColor(.headerRight, color: color)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFTextColorObject
                        expect(object?.color) == color
                    }

                    it("is possible to reset the text color of the default container") {
                        document.resetTextColor()

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFTextColorObject
                        expect(object?.color) == UIColor.black
                    }

                    it("is possible to reset the text color a specific container") {
                        document.resetTextColor(.headerRight)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFTextColorObject
                        expect(object?.color) == UIColor.black
                    }
                }

                context("table") {

                    let table = PDFTable()

                    it("is possible to add a table into the default container") {
                        document.addTable(table: table)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFTableObject
                        expect(object?.table) == table
                    }

                    it("is possible to add a table into a specific container") {
                        document.addTable(.headerRight, table: table)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFTableObject
                        expect(object?.table) == table
                    }
                }

                context("list") {

                    let indentations: [(pre: CGFloat, past: CGFloat)] = [(pre: 0, past: 10)]
                    let list = PDFList(indentations: indentations)

                    it("is possible to add a list into the default container") {
                        document.addList(list: list)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFListObject
                        expect(object?.list == list).to(beTrue())
                    }

                    it("is possible add a list into a specific container") {
                        document.addList(.headerRight, list: list)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFListObject
                        expect(object?.list) == list
                    }
                }

                context("indentation") {

                    let indentation: CGFloat = 20.0
                    let leftSide = true

                    it("is possible to set indentation of default container") {
                        document.setIndentation(indent: indentation, left: leftSide)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFIndentationObject
                        expect(object?.indentation) == indentation
                        expect(object?.left) == leftSide
                    }

                    it("is possible to set indentation of specific container") {
                        document.setIndentation(.headerRight, indent: indentation, left: leftSide)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFIndentationObject
                        expect(object?.indentation) == indentation
                        expect(object?.left) == leftSide
                    }
                }

                context("absolute offset") {

                    let offset: CGFloat = 20.0

                    it("is possible to set absolute offset of default container") {
                        document.setAbsoluteOffset(offset: offset)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.contentLeft

                        let object = document.objects[0].1 as? PDFOffsetObject
                        expect(object?.offset) == offset
                    }

                    it("is possible to set absolute offset of specific container") {
                        document.setAbsoluteOffset(.headerRight, offset: offset)

                        expect(document.objects).to(haveCount(1))
                        expect(document.objects[0].0) == PDFContainer.headerRight

                        let object = document.objects[0].1 as? PDFOffsetObject
                        expect(object?.offset) == offset
                    }
                }

                it("is possible to create a new page") {
                    document.createNewPage()

                    expect(document.objects).to(haveCount(1))
                    expect(document.objects[0].0) == PDFContainer.contentLeft
                    expect(document.objects[0].1 as? PDFPageBreakObject).toNot(beNil())
                }
            }
        }
    }

}
