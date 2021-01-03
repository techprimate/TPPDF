import Foundation
import Quick
import Nimble
@testable import TPPDF
import PDFKit

class ExternalDocumentTests: QuickSpec {

    override func spec() {
        describe("External Document") {
            context("only document") {
                context("debug mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document is empty
                    //  - Debug mode is active
                    // Expected Result:
                    //  - Render all pages in external document
                    //  - Do not render anything else than external document pages
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages with debug overlay") {
                        let document = PDFDocument(format: .a4)
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))

                        let generator = PDFGenerator(document: document)
                        generator.debug = true

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 50

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 50

                        // TODO: compare output PDF to reference PDF
                    }
                }

                context("normal mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document is empty
                    //  - Debug mode is not active
                    // Expected Result:
                    //  - Render all pages in external document
                    //  - Do not render anything else than external document pages
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages") {
                        let document = PDFDocument(format: .a4)
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))

                        let generator = PDFGenerator(document: document)
                        generator.debug = false

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 50

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 50

                        // TODO: compare output PDF to reference PDF
                    }
                }
            }
            context("content before document") {
                context("debug mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document contains content
                    //  - Debug mode is active
                    // Expected Result:
                    //  - Render content before external document
                    //  - Render all pages in external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages with debug overlay") {
                        let document = PDFDocument(format: .a4)
                        document.add(text: "Text before external document")
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))

                        let generator = PDFGenerator(document: document)
                        generator.debug = true

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 51

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 51

                        // TODO: compare output PDF to reference PDF
                    }
                }

                context("normal mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document contains content
                    //  - Debug mode is not active
                    // Expected Result:
                    //  - Render content before external document
                    //  - Render all pages in external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages") {
                        let document = PDFDocument(format: .a4)
                        document.add(text: "Text before external document")
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))

                        let generator = PDFGenerator(document: document)
                        generator.debug = false

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 51

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 51

                        // TODO: compare output PDF to reference PDF
                    }
                }
            }

            context("content after document") {
                context("debug mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document is empty before adding external document
                    //  - More content is added after external document
                    //  - Debug mode is active
                    // Expected Result:
                    //  - Render all pages in external document
                    //  - Render content after external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages with debug overlay") {
                        let document = PDFDocument(format: .a4)
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))
                        document.add(text: "Text after external document")

                        let generator = PDFGenerator(document: document)
                        generator.debug = true

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 51

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 51

                        // TODO: compare output PDF to reference PDF
                    }
                }

                context("normal mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document is empty before adding external document
                    //  - More content is added after external document
                    //  - Debug mode is not active
                    // Expected Result:
                    //  - Render all pages in external document
                    //  - Render content after external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages") {
                        let document = PDFDocument(format: .a4)
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))
                        document.add(text: "Text after external document")

                        let generator = PDFGenerator(document: document)
                        generator.debug = false

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 51

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 51

                        // TODO: compare output PDF to reference PDF
                    }
                }
            }

            context("document between content") {
                context("debug mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document has content before external documnet
                    //  - More content is added after external document
                    //  - Debug mode is active
                    // Expected Result:
                    //  - Render content before external document
                    //  - Render all pages in external document
                    //  - Render content after external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages with debug overlay") {
                        let document = PDFDocument(format: .a4)
                        document.add(text: "Text before external document")
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))
                        document.add(text: "Text after external document")

                        let generator = PDFGenerator(document: document)
                        generator.debug = true

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 52

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 52

                        // TODO: compare output PDF to reference PDF
                    }
                }

                context("normal mode") {

                    // Test Case:
                    // Precondition:
                    //  - Document has content before external documnet
                    //  - More content is added after external document
                    //  - Debug mode is not  active
                    // Expected Result:
                    //  - Render content before external document
                    //  - Render all pages in external document
                    //  - Render content after external document
                    // Notes:
                    //  - This test needs to be run with and without debug mode to validate side effects
                    it("should draw the pdf pages") {
                        let document = PDFDocument(format: .a4)
                        document.add(text: "Text before external document")
                        document.add(externalDocument: .init(url: Bundle.module.url(forResource: "50-pages", withExtension: "pdf")!))
                        document.add(text: "Text after external document")

                        let generator = PDFGenerator(document: document)
                        generator.debug = false

                        var outputURL: URL! = nil
                        expect {
                            outputURL = try generator.generateURL(filename: "output.pdf")
                        }.toNot(throwError())
                        expect(generator.totalPages) == 52

                        let outputDoc = PDFKit.PDFDocument(url: outputURL)
                        expect(outputDoc?.pageCount) == 52

                        // TODO: compare output PDF to reference PDF
                    }
                }
            }
        }
    }
}
