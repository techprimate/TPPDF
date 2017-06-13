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
        
        let tableData: [[String]] = [
            ["",    "Company",                     "Contact",              "Country"],
            ["1",    "Alfreds Futterkiste",         "Maria Anders",         "Germany"],
            ["2",    "Berglunds snabbköp",          "Christina Berglund",   "Sweden"],
            ["3",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["4",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["5",    "Island Trading",              "Helen Bennett",        "UK"],
            ["6",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["7",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["8",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["9",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["10",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["11",    "Island Trading",              "Helen Bennett",        "UK"],
            ["12",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["13",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["14",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["15",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["16",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["17",    "Island Trading",              "Helen Bennett",        "UK"],
            ["18",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["19",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["20",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["21",    "Company",                     "Contact",              "Country"]
        ]
        let tableAlignment: [[TableCellAlignment]] = [
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
        let tableWidth: [CGFloat] = [
            0.08, 0.4, 0.251, 0.251
        ]
        
        let tableStyle = TableStyleDefaults.simple
        tableStyle.setCellStyle(row: 2, column: 3, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        tableStyle.setCellStyle(row: 20, column: 1, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        
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
