//
//  PDFJSONSerializable_Spec.swift
//  TPPDF_Tests
//
//  Created by Philip Niedertscheider on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Quick
import Nimble
@testable import TPPDF

class PDFJSONSerialization_Spec : QuickSpec {

    override func spec() {
        describe("PDFJSONSerialization") {

            context("JSON String") {

                class CustomJSON: PDFJSONSerializable {

                    static var invalidJSON = false

                    var JSONRepresentation: AnyObject {
                        if CustomJSON.invalidJSON {
                            return CustomJSON() as AnyObject
                        }
                        return ["TEST"] as AnyObject
                    }
                }

                beforeEach {
                    CustomJSON.invalidJSON = false
                }

                it("can be converted into a JSON string") {
                    let instance = CustomJSON()
                    expect(instance.toJSON()) == "[\"TEST\"]"
                }

                it("can not be converted if invalid json object") {
                    let instance = CustomJSON()
                    CustomJSON.invalidJSON = true

                    expect(instance.toJSON()).to(beNil())
                }
            }
            context("Array") {

                it("can be representated") {
                    let examples = [["ABC", "DEF", "GHI"], [1, 2, 3]]

                    let converted = examples.JSONRepresentation
                    expect(converted as? [AnyObject]).toNot(beNil())

                    guard let convertedArray = converted as? [AnyObject] else {
                        return
                    }

                    expect(convertedArray[0] as? [String]) == ["ABC", "DEF", "GHI"]
                    expect(convertedArray[1] as? [Int]) == [1, 2, 3]
                }
            }

            context("Dictionary") {

                it("can be representated") {
                    let examples: [String: Any] = [
                        "1": CGRect(x: 1, y: 2, width: 3, height: 4),
                        "2": CGPoint(x: 1, y: 2),
                        "3": CGSize(width: 1, height: 2)
                    ]

                    let converted = examples.JSONRepresentation
                    expect(converted as? [String: Any]).toNot(beNil())

                    guard let convertedDict = converted as? [String: Any] else {
                        return
                    }

                    let frameDict = convertedDict["1"] as? [String: Any]
                    expect(frameDict).toNot(beNil())

                    let originDict = frameDict?["origin"] as? [String: Int]
                    expect(originDict).toNot(beNil())
                    expect(originDict) == [
                        "x": 1,
                        "y": 2
                    ]

                    let sizeDict = frameDict?["size"] as? [String: Int]
                    expect(sizeDict).toNot(beNil())
                    expect(sizeDict) == [
                        "width": 3,
                        "height": 4
                    ]

                    expect(convertedDict["2"] as? [String: Int]) == [
                        "x": 1,
                        "y": 2
                    ]
                    expect(convertedDict["3"] as? [String: Int]) == [
                        "width": 1,
                        "height": 2
                    ]
                }
            }

            context("Tuple") {

                let points = [
                    (x: 10, y: 20),
                    (30, 40)
                ]

                let points2 = [
                    (x: 10, y: 20)
                ]

                let converted = points.JSONRepresentation as? [AnyObject]
                let converted2 = points2.JSONRepresentation as? [AnyObject]

                it("can be representated") {
                    expect(converted2?[0] as? [String: Int]) == [
                        "x": 10,
                        "y": 20
                    ]

                    expect(converted?[0] as? [String: Int]) == [
                        ".0": 10,
                        ".1": 20
                    ]

                    expect(converted?[1] as? [String: Int]) == [
                        ".0": 30,
                        ".1": 40
                    ]
                }
            }

            context("UIImage") {

                it("can not be representated if invalid image") {
                    expect(UIImage().JSONRepresentation is NSNull).to(beTrue())
                }

                it("can not representated as Base64") {
                    let size = CGSize(width: 1, height: 1)

                    UIGraphicsBeginImageContext(CGSize(width: 2 * size.width, height: 2 * size.height))

                    var rect = CGRect(origin: .zero, size: size)
                    var path = UIBezierPath(rect: rect)
                    UIColor.blue.setFill()
                    path.fill()

                    rect = CGRect(x: size.width, y: 0, width: size.width, height: size.height)
                    path = UIBezierPath(rect: rect)
                    UIColor.green.setFill()
                    path.fill()

                    rect = CGRect(x: 0, y: size.height, width: size.width, height: size.height)
                    path = UIBezierPath(rect: rect)
                    UIColor.red.setFill()
                    path.fill()

                    rect = CGRect(x: size.width, y: size.height, width: size.width, height: size.height)
                    path = UIBezierPath(rect: rect)
                    UIColor.orange.setFill()
                    path.fill()

                    let image = UIGraphicsGetImageFromCurrentImageContext()!
                    UIGraphicsEndImageContext()

                    expect(image.JSONRepresentation as? String) == "/9j/4AAQSkZJRgABAQAASABIAAD/4QBYRXhpZgAATU0AKgAAAAgAAgESAAMAAAABAAEAAIdpAAQAAAABAAAAJgAAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAAqADAAQAAAABAAAAAgAAAAD/7QA4UGhvdG9zaG9wIDMuMAA4QklNBAQAAAAAAAA4QklNBCUAAAAAABDUHYzZjwCyBOmACZjs+EJ+/8AAEQgAAgACAwERAAIRAQMRAf/EAB8AAAEFAQEBAQEBAAAAAAAAAAABAgMEBQYHCAkKC//EALUQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEBAQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUhMQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp6vLz9PX29/j5+v/bAEMAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/bAEMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/dAAQAAf/aAAwDAQACEQMRAD8A9m+B9tbWnwW+EFra28Fra23wu8AW9tbW8KQ29vBD4T0mOGCCGNVjihijVY4441VERVVFCgBf+ZfxYz/PeKfFLxK4m4mzrNuIuJOIuP8AjLPeIOIM9zLGZvnme55m/EWY5hm2c5zm2YVsRj8zzXM8fiMRjsxzHHYivjMbjK9bE4mtVrVZzl/up4n/AECvoMYjxL8Q8RX+hf8AROr16/HPFtatWrfR08H6tWtVq5/mE6lWrUnwa51KlSbc5zm3Kcm5SbbbP//Z"
                }
            }

            context("UIColor") {

                it("can be representated") {
                    let representable = UIColor.purple.JSONRepresentation
                    expect(representable as? String) == "#7f007f"
                }
            }

            context("Optional") {

                it("can be reprsentated") {
                    let objects = [
                        nil,
                        "ASDF"
                        ] as [String?]

                    let optionalsArray = objects.JSONRepresentation as? [AnyObject?]
                    expect(optionalsArray).toNot(beNil())
                    expect(optionalsArray?[0]).to(beNil())
                    expect(optionalsArray?[1] as? String) == "ASDF"
                }
            }

            it("can not represent unknown object") {
                let objects = [
                    PDFGraphics()
                ] as [AnyObject]

                expect((objects.JSONRepresentation as? [String])?[0]) == "UNKNOWN"
            }

            it("can be converted into a JSON string if valid") {
                let examples = [
                    "A", "B", "C"
                ]

                expect(examples.toJSON()) == "[\"A\",\"B\",\"C\"]"
            }

            it("can be converted into a JSON string if content is invalid") {
                let examples = [
                    PDFGraphics()
                ]

                expect(examples.toJSON()) == "[\"UNKNOWN\"]"
            }
        }
    }

}
