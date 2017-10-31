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
        generatePDF()
    }
    
    func generatePDF() {
        /* ---- Execution Metrics ---- */
        var startTime = Date()
        /* ---- Execution Metrics ---- */
        
        let document = PDFDocument(format: .a4)
        
        // Set document meta data
        document.info.title = "TPPDF Example"
        document.info.subject = "Building a PDF easily"
        document.info.ownerPassword = "Password123"
        
        // Set spacing of header and footer
        document.layout.space.header = 50
        document.layout.space.footer = 25
        
        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure({ (page, total) -> String in
            return "\(page) / \(total)"
        }), range: (1, 10), hiddenPages: [3, 7])
        
        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        // Also you can define a quality in percent between 0.0 and 1.0 which is the JPEG compression quality.
        let image = PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150), quality: 0.9)
        document.addImage(.contentCenter, image: image)
        
        // Add some spacing below image
//        document.addSpace(space: 15.0)
        
        // Create and add an title as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "TPPDF", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 50.0),
            .paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            .foregroundColor: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
            ])
//        document.addAttributedText(.contentCenter, text: title)
        
        // Set document font and document color. This will be used only for simple text until it is reset.
//        document.setFont(font: UIFont.systemFont(ofSize: 18.0))
//        document.setTextColor(color: UIColor.lightGray)
        
//        document.addText(.contentCenter, text: "Create PDF documents easily.")
        
        // Reset font and text color
//        document.resetFont()
//        document.resetTextColor()
        
        // Create a list with level indentations
//        let list = PDFList(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        
//        list.addItems([
//            PDFListItem(symbol: .numbered(value: nil))
//                .addItems([
//                    PDFListItem(content: "Introduction")
//                        .addItems([
//                            PDFListItem(symbol: .numbered(value: nil))
//                                .addItems([
//                                    PDFListItem(content: "Text"),
//                                    PDFListItem(content: "Attributed Text"),
//                                    ])
//                            ])
//                    ])
//            ])
        
//        document.addList(list: list)
        
        /*
        // Set Font for headline
        
        pdf.setFont(font: UIFont.systemFont(ofSize: 20.0))
        
        // Add headline with extra spacing
        
        pdf.addSpace(space: 30)
        pdf.addText(text: "1. Introduction")
        pdf.addSpace(space: 10)
        
        // Set font for text
        
        pdf.setFont(font: UIFont.systemFont(ofSize: 13.0))
        
        // Add long simple text. This will automatically word wrap if content width is not enough.
        
        pdf.addText(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        pdf.addSpace(space: 10)
        var array = [String]()
        for i in 0...200 {
            array += ["\(i)"]
        }
        pdf.addText(text: array.joined(separator: ", "))
        pdf.addSpace(space: 10)
        pdf.addText(text: "TPPDF includes many different features:")
        
        pdf.addSpace(space: 10)
        
        // Simple bullet point list
        
        let featureList = PDFList(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        
        featureList.addItem(PDFListItem(symbol: .dot).addItems([
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
        pdf.addList(list: featureList)
        
        // Insert page break
        
        pdf.createNewPage()
        
        // Create a line separator
        
        pdf.addSpace(space: 10)
        pdf.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        pdf.addSpace(space: 10)
        
        
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
                PDFImage(image: UIImage(named: "Image-1.jpg")!, caption: NSAttributedString(string: "Waterfall", attributes: captionAttributes)),
                PDFImage(image: UIImage(named: "Image-2.jpg")!, caption: NSAttributedString(string: "Forrest", attributes: captionAttributes)),
                ],
            [
                PDFImage(image: UIImage(named: "Image-3.jpg")!, caption: NSAttributedString(string: "Fireworks", attributes: captionAttributes)),
                PDFImage(image: UIImage(named: "Image-4.jpg")!, caption: NSAttributedString(string: "Field", attributes: captionAttributes)),
                ]
        ]
        
        // Add first row of images
        
        pdf.addImagesInRow(images: images[0], spacing: 10)
        
        // Add spacing between image rows
        
        pdf.addSpace(space: 10)
        
        // Add second row of images
        
        pdf.addImagesInRow(images: images[1], spacing: 10)
        
        // Finish image collage with another line separator
        
        pdf.addSpace(space: 10)
        pdf.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        pdf.addSpace(space: 10)
        
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
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.center, .center, .center, .left],
                    [.left, .left, .left, .left]
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
            borders: (left: PDFLineStyle(),
                      top: PDFLineStyle(),
                      right: PDFLineStyle(),
                      bottom: PDFLineStyle()),
            
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
        
        pdf.addTable(table: table)
        
        // Add more text after the table
        
        pdf.addText(text: "Just adding more text here...")
        */
        
        /* ---- Execution Metrics ---- */
        print("Preparation took: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* ---- Execution Metrics ---- */
        
        // Convert document to JSON String for debugging
        let json = document.toJSON(options: JSONSerialization.WritingOptions.prettyPrinted) ?? "nil"
        print(json)
        
        do {
            // Enable debug mode if necessary
            PDFGenerator.debug = true
            
            // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
            let url = try PDFGenerator.generateURL(document: document, filename: "Example.pdf", progress: nil)
            
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
        if (hours > 1) {
            result.append(String(format: "%.0f", hours) + "h")
        }
        if (minutes > 1) {
            result.append(String(format: "%.0f", minutes) + "m")
        }
        if (seconds > 1) {
            result.append(String(format: "%.0f", seconds) + "s")
        }
        if (ms > 1) {
            result.append(String(format: "%.0f", ms) + "ms")
        }
        if (ns > 0.001) {
            result.append(String(format: "%.3f", ns) + "ns")
        }
        return result.joined(separator: " ")
    }
}
