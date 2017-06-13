//
//  ViewController.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 11/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
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
        
        pdf.setPageNumbering(.footerCenter, style: PaginationStyle.Roman(template: "%@"), from: 1, to: 4, hiddenPages: [4])
        
        let table = Table()
        table.data = [
            [nil,                            TableContent(content: "Company"),                     TableContent(content: "Contact"),              TableContent(content: "Country")],
            [TableContent(content: "1"),     TableContent(content: "Alfreds Futterkiste"),         TableContent(content: "Maria Anders"),         TableContent(content: "Germany")],
            [TableContent(content: "2"),     TableContent(content: "Berglunds snabbköp"),          TableContent(content: "Christina Berglund"),   TableContent(content: "Sweden")],
            [TableContent(content: "3"),     TableContent(content: "Centro comercialMoctezuma"),   TableContent(content: "Francisco Chang"),      TableContent(content: "Mexico")],
            [TableContent(content: "4"),     TableContent(content: "Ernst Handel"),                TableContent(content: "Roland Mendel"),        TableContent(content: "Austria")],
            [TableContent(content: "5"),     TableContent(content: "Island Trading"),              TableContent(content: "Helen Bennett"),        TableContent(content: "UK")],
            [TableContent(content: "6"),     TableContent(content: "Königlich Essen"),             TableContent(content: "Philip Cramer"),        TableContent(content: "Germany")],
            [TableContent(content: "7"),     TableContent(content: "Laughing Bacchus"),            TableContent(content: "Yoshi Tannamuri"),      TableContent(content: "Canada")],
            [TableContent(content: "8"),     TableContent(content: "Magazzini Alimentari"),        TableContent(content: "Giovanni Rovelli"),     TableContent(content: "Italy")],
            [TableContent(content: "9"),     TableContent(content: "Centro comercialMoctezuma"),   TableContent(content: "Francisco Chang"),      TableContent(content: "Mexico")],
            [TableContent(content: "10"),    TableContent(content: "Ernst Handel"),                TableContent(content: "Roland Mendel"),        TableContent(content: "Austria")],
            [TableContent(content: "11"),    TableContent(content: "Island Trading"),              TableContent(content: "Helen Bennett"),        TableContent(content: "UK")],
            [TableContent(content: "12"),    TableContent(content: "Königlich Essen"),             TableContent(content: "Philip Cramer"),        TableContent(content: "Germany")],
            [TableContent(content: "13"),    TableContent(content: "Laughing Bacchus"),            TableContent(content: "Yoshi Tannamuri"),      TableContent(content: "Canada")],
            [TableContent(content: "14"),    TableContent(content: "Magazzini Alimentari"),        TableContent(content: "Giovanni Rovelli"),     TableContent(content: "Italy")],
            [TableContent(content: "15"),    TableContent(content: "Centro comercialMoctezuma"),   TableContent(content: "Francisco Chang"),      TableContent(content: "Mexico")],
            [TableContent(content: "16"),    TableContent(content: "Ernst Handel"),                TableContent(content: "Roland Mendel"),        TableContent(content: "Austria")],
            [TableContent(content: "17"),    TableContent(content: "Island Trading"),              TableContent(content: "Helen Bennett"),        TableContent(content: "UK")],
            [TableContent(content: "18"),    TableContent(content: "Königlich Essen"),             TableContent(content: "Philip Cramer"),        TableContent(content: "Germany")],
            [TableContent(content: "19"),    TableContent(content: "Laughing Bacchus"),            TableContent(content: "Yoshi Tannamuri"),      TableContent(content: "Canada")],
            [TableContent(content: "20"),    TableContent(content: "Magazzini Alimentari"),        TableContent(content: "Giovanni Rovelli"),     TableContent(content: "Italy")],
            [nil,                            TableContent(content: "Footer Company"),              TableContent(content: "Footer Contact"),       TableContent(content: "Footer Country")]
        ]
        table.alignments = [
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left]
        ]
        table.widths = [
            0.08, 0.4, 0.251, 0.251
        ]
        table.setCellStyle(row: 2, column: 3, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        table.setCellStyle(row: 20, column: 1, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        table.style.footerStyle = TableCellStyle(
            fillColor: UIColor(colorLiteralRed: 0.171875,
                               green: 0.2421875,
                               blue: 0.3125,
                               alpha: 1.0),
            textColor: UIColor.white,
            font: UIFont.systemFont(ofSize: 10),
            borderLeft: LineStyle(),
            borderTop: LineStyle(),
            borderRight: LineStyle(),
            borderBottom: LineStyle())
        table.style.footerCount = 2;
        
        table.padding = 8
        table.margin = 0
        table.showHeadersOnEveryPage = true
        
        pdf.addTable(table: table)
        
        /* Execution Metrics */
        print("Preparation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
        
        let url = pdf.generatePDFfile("Pasta with tomato sauce")
        
        /* Execution Metrics */
        print("Generation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
        
        (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
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
