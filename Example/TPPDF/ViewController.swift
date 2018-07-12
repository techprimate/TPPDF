//
//  ViewController.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateTestPDF()
        generateExamplePDF()
    }

    func generateTestPDF() {
        let document = PDFDocument(format: .a4)

//        let section = PDFSection(columnWidths: [0.3, 0.7])
//        section.columns[0].addText(.left, text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem")
//        section.columns[1].addText(.left, text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
//
//        document.addSection(section)
//
//        document.addSection(section)

        do {
            // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
            let url = try PDFGenerator.generateURL(document: document, filename: "Example.pdf", progress: {
                (progressValue: CGFloat) in
                print("progress: ", progressValue)
            }, debug: true)

            // Load PDF into a webview from the temporary file
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
    }
    
    func generateExamplePDF() {
        /* ---- Execution Metrics ---- */
        var startTime = Date()
        /* ---- Execution Metrics ---- */
        
        let document = PDFDocument(format: .a4)
        
        // Set document meta data
        document.info.title = "TPPDF Example"
        document.info.subject = "Building a PDF easily"
        document.info.ownerPassword = "Password123"
        
        // Set spacing of header and footer
        document.layout.space.header = 5
        document.layout.space.footer = 5
        
        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure { (page, total) -> String in
            return "\(page) / \(total)"
            }, range: (1, 20), hiddenPages: [3, 7], textAttributes: [
            .font: UIFont.boldSystemFont(ofSize: 15.0),
            .foregroundColor: UIColor.green
        ])

        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        // Also you can define a quality in percent between 0.0 and 1.0 which is the JPEG compression quality. This is applied if the option `compress` is set.
        let logoImage = PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150), quality: 0.9, options: [.resize, .compress])
        document.addImage(.contentCenter, image: logoImage)

        // Create and add an title as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "TPPDF", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 50.0),
            .foregroundColor: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
            ])
        document.addAttributedText(.contentCenter, text: title)

        // Add some spacing below title
        document.addSpace(space: 15.0)

        // Set document font and document color. This will be used only for simple text until it is reset.
        document.setFont(font: UIFont.systemFont(ofSize: 18.0))
        document.setTextColor(color: UIColor.red)

        document.addText(.contentCenter, text: "Create PDF documents easily.")

        // Reset font and text color
        document.resetFont()
        document.resetTextColor()

        // Add some spacing below subtitle
        document.addSpace(space: 10.0)

        // Create a list with level indentations
        let list = PDFList(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])

        list.addItem(PDFListItem(symbol: .numbered(value: nil))
            .addItem(PDFListItem(content: "Introduction")
                .addItem(PDFListItem(symbol: .numbered(value: nil))
                    .addItem(PDFListItem(content: "Text"))
                    .addItem(PDFListItem(content: "Attributed Text"))
            ))
            .addItem(PDFListItem(content: "Usage")))

        document.addList(list: list)

        // Set Font for headline
        
        document.setFont(font: UIFont.systemFont(ofSize: 20.0))

        // Add headline with extra spacing
        
        document.addSpace(space: 20)
        document.addText(text: "1. Introduction")
        document.addSpace(space: 10)

        // Set font for text
        
        document.setFont(font: UIFont.systemFont(ofSize: 13.0))

        // Add long simple text. This will automatically word wrap if content width is not enough.
        
        document.addText(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        document.addSpace(space: 10)

        document.addText(text: "TPPDF includes many different features:")
        document.addSpace(space: 10)

        // Simple bullet point list
        
        let featureList = PDFList(indentations: [(pre: 10.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        
        featureList.addItem(PDFListItem(symbol: .dot)
            .addItems([
                PDFListItem(content: "Simple text drawing"),
                PDFListItem(content: "Advanced text drawing using AttributedString"),
                PDFListItem(content: "Multi-layer rendering by simply setting the offset"),
                PDFListItem(content: "Fully calculated content sizing"),
                PDFListItem(content: "Automatic page wrapping"),
                PDFListItem(content: "Customizable pagination"),
                PDFListItem(content: "Fully editable header and footer"),
                PDFListItem(content: "Simple image positioning and rendering"),
                PDFListItem(content: "Image captions")
                ]))
        document.addList(list: featureList)
        document.addList(list: featureList)
        document.addList(list: featureList)
        document.addList(list: featureList)

        // Create a line separator

        document.addSpace(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        document.addSpace(space: 10)

        // Insert page break

        document.createNewPage()


        // Create attributes for captions

        let captionAttributes: [NSAttributedStringKey: AnyObject] = [
            .font: UIFont.italicSystemFont(ofSize: 15.0),
            .paragraphStyle: { () -> NSMutableParagraphStyle in
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            .foregroundColor: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0),
        ]

        // Create an image collage with captions

        let images = [
            [
                PDFImage(image: UIImage(named: "Image-1.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "In this picture you can see a beautiful waterfall!",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-2.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Forrest",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes)))
                ],
            [
                PDFImage(image: UIImage(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-4.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Field",
                                                                             attributes: captionAttributes))),
                ]
        ]

        // Add first row of images

        document.addImagesInRow(images: images[0], spacing: 10)

        // Add spacing between image rows

        document.addSpace(space: 10)

        // Add second row of images

        document.addImagesInRow(images: images[1], spacing: 10)
        
        // Add many rows of images to test break a page
        document.addImagesInRow(images: images[1], spacing: 10)
        document.addImagesInRow(images: images[1], spacing: 10)
        document.addImagesInRow(images: images[1], spacing: 10)
        document.addImagesInRow(images: images[1], spacing: 10)
        document.addImagesInRow(images: images[1], spacing: 10)

        // Finish image collage with another line separator

        document.addSpace(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        document.addSpace(space: 10)

        // Create a table

        let table = PDFTable()

        // Tables can contain Strings, Numbers, Images or nil, in case you need an empty cell. If you add a unknown content type, an error will be thrown and the rendering will stop.

        do {
            try table.generateCells(
                data:
                [
                    [nil, "Name", "Image", "Description"],
                    [1, "Waterfall", UIImage(named: "Image-1.jpg")!, "Water flowing down stones."],
                    [2, "Forrest", UIImage(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
                    [3, "Fireworks", UIImage(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
                    [4, "Fields", UIImage(named: "Image-4.jpg")!, "Crops growing big and providing food."],
                    [1, "Waterfall", UIImage(named: "Image-1.jpg")!, "Water flowing down stones."],
                    [2, "Forrest", UIImage(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
                    [3, "Fireworks", UIImage(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
                    [4, "Fields", UIImage(named: "Image-4.jpg")!, "Crops growing big and providing food."],
                    [nil, nil, nil, "Many beautiful places"]
                ],
                alignments:
                [
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                ])
        } catch PDFError.tableContentInvalid(let value) {
            // In case invalid input is provided, this error will be thrown.

            print("This type of object is not supported as table content: " + String(describing: (type(of: value))))
        } catch {
            // General error handling in case something goes wrong.

            print("Error while creating table: " + error.localizedDescription)
        }

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        table.widths = [
            0.1, 0.25, 0.35, 0.3
        ]

        // To speed up table styling, use a default and change it

        let style = PDFTableStyleDefaults.simple

        // Change standardized styles
        style.footerStyle = PDFTableCellStyle(
            colors: (
                fill: UIColor(red: 0.171875,
                              green: 0.2421875,
                              blue: 0.3125,
                              alpha: 1.0),
                text: UIColor.white
            ),
            borders: PDFTableCellBorders(left: PDFLineStyle(type: .full),
                      top: PDFLineStyle(type: .full),
                      right: PDFLineStyle(type: .full),
                      bottom: PDFLineStyle(type: .full)),

            font: UIFont.systemFont(ofSize: 10)
        )

        // Simply set the amount of footer and header rows

        style.columnHeaderCount = 1
        style.footerCount = 1

        table.style = style

        do {
            // Style each cell individually
            try table.setCellStyle(row: 1, column: 1, style: PDFTableCellStyle(colors: (fill: UIColor.yellow, text: UIColor.black)))
        } catch PDFError.tableIndexOutOfBounds(let index, let length){
            // In case the index is out of bounds

            print("Requested cell is out of bounds! \(index) / \(length)")
        } catch {
            // General error handling in case something goes wrong.

            print("Error while setting cell style: " + error.localizedDescription)
        }

        // Set table padding and margin

        table.padding = 5.0
        table.margin = 10.0

        // In case of a linebreak during rendering we want to have table headers on each page.

        table.showHeadersOnEveryPage = true

        document.addTable(table: table)

        // Add more text after the table

        document.addText(text: "Just adding more text here...")
		
		// Add multi column section
		
		let section = PDFSection(columnWidths: [0.33, 0.34, 0.33])
		section.columns[0].addText(.left, text: "left")
		section.columns[0].addText(.center, text: "center")
		section.columns[0].addText(.right, text: "right")
		section.columns[0].addText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")
		section.columns[0].addImage(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[0].addText(text: "At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[1].addText(.left, text: "left")
		section.columns[1].addText(.center, text: "center")
		section.columns[1].addText(.right, text: "right")
		section.columns[1].addText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[1].addText(.center, text: "center")
		section.columns[1].addImage(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[2].addImage(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[2].addText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[2].addText(.left, text: "left")
		section.columns[2].addText(.center, text: "center")
		section.columns[2].addText(.right, text: "right")
		section.columns[2].addText(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")
		document.addSection(section)

        // Add a floating multisection

        let floatingSection = PDFSection(columnWidths: [0.33, 0.34, 0.33])
//        floatingSection.floating = true
        floatingSection.columns[0].addText(.left, text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
        document.addSection(floatingSection)
		

        // Add text to footer

        document.addText(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 1"))
        document.addText(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 2"))
        document.addText(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 3"))

        document.addText(.footerRight, textObject: PDFSimpleText(text: "Footer Right 1"))
        document.addText(.footerRight, textObject: PDFSimpleText(text: "Footer Right 2"))
        document.addText(.footerRight, textObject: PDFSimpleText(text: "Footer Right 3"))

        document.addText(.headerLeft, textObject: PDFSimpleText(text: "Header Left 1"))
        document.addText(.headerLeft, textObject: PDFSimpleText(text: "Header Left 2"))
        document.addText(.headerLeft, textObject: PDFSimpleText(text: "Header Left 3"))

        document.addText(.headerRight, textObject: PDFSimpleText(text: "Header Right 1"))
        document.addText(.headerRight, textObject: PDFSimpleText(text: "Header Right 2"))
        document.addText(.headerRight, textObject: PDFSimpleText(text: "Header Right 3"))

        // Add  even more text

        document.createNewPage()
        document.addText(text: "Even more text!")

        /* ---- Execution Metrics ---- */
        print("Preparation took: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* ---- Execution Metrics ---- */
        
        // Convert document to JSON String for debugging
        let _ = document.toJSON(options: JSONSerialization.WritingOptions.prettyPrinted) ?? "nil"
//        print(json)

        do {
            // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
            let url = try PDFGenerator.generateURL(document: document, filename: "Example.pdf", progress: {
                (progressValue: CGFloat) in
                print("progress: ", progressValue)
            }, debug: true)

            // Load PDF into a webview from the temporary file
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
        
        /* ---- Execution Metrics ---- */
        print("Generation took: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* ---- Execution Metrics ---- */
    }
    
    /**
     Used for debugging execution time.
     Converts time interval in seconds to String.
     */
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ns = (interval * 10e8).truncatingRemainder(dividingBy: 10e5)
        let ms = (interval * 10e2).rounded(.towardZero)
        let seconds = interval.rounded(.towardZero)
        let minutes = (interval / 60).rounded(.towardZero)
        let hours = (interval / 3600).rounded(.towardZero)
        
        var result = [String]()
        if hours > 1 {
            result.append(String(format: "%.0f", hours) + "h")
        }
        if minutes > 1 {
            result.append(String(format: "%.0f", minutes) + "m")
        }
        if seconds > 1 {
            result.append(String(format: "%.0f", seconds) + "s")
        }
        if ms > 1 {
            result.append(String(format: "%.0f", ms) + "ms")
        }
        if ns > 0.001 {
            result.append(String(format: "%.3f", ns) + "ns")
        }
        return result.joined(separator: " ")
    }
}
