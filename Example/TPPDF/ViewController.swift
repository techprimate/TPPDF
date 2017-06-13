//
//  ViewController.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generatePDF()
    }
    
    func generatePDF() {
        /* Execution Metrics */
        var startTime = Date()
        /* Execution Metrics */
        
        let pdf = PDFGenerator(format: .a4)
        pdf.setPageNumbering(.footerRight, style: PaginationStyle.Roman(template: "%@"), from: 1, to: 4, hiddenPages: [4])
        
        // Set document meta data
        pdf.info.title = "TPPDF Example"
        pdf.info.subject = "Building a PDF easily"
        
        // Set spacing of header and footer
        pdf.headerSpace = 50
        pdf.footerSpace = 25
        
        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        pdf.addImage(.contentCenter, image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150))
        // Add some spacing below image
        pdf.addSpace(space: 15.0)
        
        // Create and add an title as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "TPPDF", attributes: [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 50.0),
            NSParagraphStyleAttributeName: {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
            ])
        pdf.addAttributedText(.contentCenter, text: title)
        
        // Set document font and document color. This will be used for simple text until it is reset.
        pdf.setFont(font: UIFont.systemFont(ofSize: 18.0))
        pdf.setTextColor(color: UIColor.lightGray)
        pdf.addText(.contentCenter, text: "Create PDF documents easily.")
        
        // Reset font and text color
        pdf.resetFont()
        pdf.resetTextColor()
        
        // Create a list with level indentations
        let list = List(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        // Two multiple types of list items exist
        
        list.addItems([
            ListItem(symbol: .numbered(value: nil))
                .addItems([
                    ListItem(content: "Drawing Text")
                        .addItems([
                            ListItem(symbol: .numbered(value: nil))
                                .addItems([
                                    ListItem(content: "Text"),
                                    ListItem(content: "Attributed Text"),
                                    ])
                            ])
                    ])
            ])
        
        pdf.addList(list: list)
        
        
        //        let portraitImage = UIImage(named: "PortraitImage.jpg")!
        
        //        pdf.addText(.footerCenter, text: "Created using TPPDF for iOS.")
        //        pdf.addText(.headerLeft, text: "Recipe: Pasta with tomato sauce")
        //        pdf.addLineSeparator(.headerCenter, style: LineStyle(type: .full, color: UIColor.darkGray, width: 1.0))
        //        pdf.addLineSeparator(.headerCenter, style: LineStyle(type: .full, color: UIColor.lightGray, width: 0.5))
        //
        //        let category =  NSAttributedString(string: "Category: Meal", attributes: [
        //            NSFontAttributeName : UIFont.systemFont(ofSize: 16.0),
        //            NSForegroundColorAttributeName : UIColor.darkGray
        //            ])
        //        pdf.addAttributedText(text: category)
        //
        //        pdf.addSpace(space: 12.0)
        //
        //        pdf.addLineSeparator(.headerCenter, style: LineStyle(type: .dashed, color: UIColor.darkGray, width: 1.0))
        //        pdf.addSpace(space: 12.0)
        //        pdf.addSpace(space: 12.0)
        //        pdf.addLineSeparator(.headerCenter, style: LineStyle(type: .dashed, color: UIColor.lightGray, width: 1.0))
        //
        //        pdf.addSpace(space: 12.0)
        //
        //        pdf.setFont(font: UIFont.italicSystemFont(ofSize: 19))
        //        pdf.addText(text: "Explain how to prep and cook this recipe here.\n\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et ")
        //        pdf.resetFont()
        //
        //        pdf.addSpace(space: 12.0)
        
        //        pdf.addImagesInRow(images: [image, portraitImage], captions: [NSAttributedString(string: "Pasta with tomato sauce"), NSAttributedString(string: "Pasta with tomato sauce")])
        //        pdf.addImage(.contentCenter, image: portraitImage, size: CGSize(width: portraitImage.size.width, height: portraitImage.size.height / 4), caption: NSAttributedString(string: "Pasta with tomato sauce"))
        //        pdf.addImage(.contentCenter, image: image, sizeFit: .width)
        
        //        let ingridients = NSMutableAttributedString(string: "Ingridients")
        //        ingridients.addAttributes([
        //            NSFontAttributeName : UIFont.systemFont(ofSize: 20.0),
        //            NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0,
        //                                                     alpha: 1.0)
        //            ], range: NSMakeRange(0, ingridients.length))
        //        pdf.addAttributedText(text: ingridients)
        //
        //        pdf.addSpace(space: 6.0)
        //
        //        let ingridientsString: String = {
        //            var result = ""
        //            for i in 1...5 {
        //                result = result + "Ingridient \(i)\n"
        //            }
        //            return result
        //        }()
        //        pdf.addText(text: ingridientsString, lineSpacing: 4.0)
        //
        //        pdf.addSpace(space: 12.0)
        //
        //        let descriptionHeader = NSMutableAttributedString(string: "Description")
        //        descriptionHeader.addAttributes([
        //            NSFontAttributeName : UIFont.systemFont(ofSize: 20.0),
        //            NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0,
        //
        //                                                     alpha: 1.0)
        //            ], range: NSMakeRange(0, descriptionHeader.length))
        //        pdf.addAttributedText(text: descriptionHeader)
        //
        //        pdf.addSpace(space: 6.0)
        //        pdf.addText(text: "Explain how to prep and cook this recipe here.\n\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et ")
        //        pdf.setIndentation(indent: 50)
        //        pdf.addText(text: "dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.")
        //        pdf.setAbsoluteOffset(offset: 450)
        //        pdf.addText(text: "Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,")
        //
        //        pdf.createNewPage()
        //        pdf.addText(text: "Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,")
        //
        //
        //
        //
        //        let table = Table()
        //        do {
        //            try table.setData(data: [
        //                [nil,    "Company",                     "Contact",              "Country"],
        //                ["1",    UIImage(named: "Image.jpg"),         "Maria Anders",         "Germany"],
        //                ["2",    "Berglunds snabbköp",          "Christina Berglund",   "Sweden"],
        //                ["3",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
        //                ["4",    "Ernst Handel",                "Roland Mendel",        "Austria"],
        //                ["5",    "Island Trading",              "Helen Bennett",        "UK"],
        //                ["6",    "Königlich Essen",             "Philip Cramer",        "Germany"],
        //                ["7",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
        //                ["8",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
        //                ["9",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
        //                ["10",    "Ernst Handel",                "Roland Mendel",        "Austria"],
        //                ["11",    "Island Trading",              "Helen Bennett",        "UK"],
        //                ["12",    "Königlich Essen",             "Philip Cramer",        "Germany"],
        //                ["13",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
        //                ["14",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
        //                ["15",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
        //                ["16",    "Ernst Handel",                "Roland Mendel",        "Austria"],
        //                ["17",    "Island Trading",              "Helen Bennett",        "UK"],
        //                ["18",    "Königlich Essen",             "Philip Cramer",        "Germany"],
        //                ["19",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
        //                ["20",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
        //                [nil,    "Footer 1",                     "Footer 2",              "Footer 3"]
        //                ])
        //        } catch TPPDFError.tableContentInvalid(let value) {
        //            print("This type of object is not supported as table content: " + String(describing: (type(of: value))))
        //        } catch {
        //            print("Error while creating table: " + error.localizedDescription)
        //        }
        //
        //        table.alignments = [
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left],
        //            [.center, .left, .center, .left]
        //        ]
        //        table.widths = [
        //            0.08, 0.4, 0.251, 0.251
        //        ]
        //        table.setCellStyle(row: 2, column: 3, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        //        table.setCellStyle(row: 20, column: 1, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        //        table.style.footerStyle = TableCellStyle(
        //            fillColor: UIColor(colorLiteralRed: 0.171875,
        //                               green: 0.2421875,
        //                               blue: 0.3125,
        //                               alpha: 1.0),
        //            textColor: UIColor.white,
        //            font: UIFont.systemFont(ofSize: 10),
        //            borderLeft: LineStyle(),
        //            borderTop: LineStyle(),
        //            borderRight: LineStyle(),
        //            borderBottom: LineStyle())
        //        table.style.footerCount = 2;
        //
        //        table.padding = 8
        //        table.margin = 0
        //        table.showHeadersOnEveryPage = true
        //
        //        pdf.addTable(table: table)
        
        /* Execution Metrics */
        print("Preparation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
        
        do {
            let url = try pdf.generatePDFfile("Pasta with tomato sauce")
            
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
        
        /* Execution Metrics */
        print("Generation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
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
