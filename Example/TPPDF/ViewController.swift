//
//  ViewController.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressView: UIProgressView!

    var progressObserver: NSObjectProtocol!

    public var exampleFactory: ExampleFactory?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        generateExamplePDF()
    }

    private var observer: NSObjectProtocol!

    func generateExamplePDF() {
        /* ---- Execution Metrics ---- */
        var startTime = CFAbsoluteTimeGetCurrent()
        /* ---- Execution Metrics ---- */

        guard let documents = exampleFactory?.generateDocument() else {
            return
        }

        /* ---- Execution Metrics ---- */
        print("Preparation took: " + stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
        startTime = CFAbsoluteTimeGetCurrent()
        /* ---- Execution Metrics ---- */
        
        let generator: PDFGeneratorProtocol
        if documents.count > 1 {
            generator = PDFMultiDocumentGenerator(documents: documents)
        } else {
            generator = PDFGenerator(document: documents.first!)
        }

        self.progressView.observedProgress = generator.progress
        observer = generator.progress.observe(\.completedUnitCount) { (p, _) in
            print(p.localizedDescription ?? "")
        }
        DispatchQueue.global(qos: .background).async {
            do {
                let url = try generator.generateURL(filename: "Example.pdf")

                /* ---- Execution Metrics ---- */
                print("Generation took: " + self.stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
                /* ---- Execution Metrics ---- */

                DispatchQueue.main.async {
                    self.progressView.isHidden = true
                    // Load PDF into a webview from the temporary file
                    self.webView.loadRequest(URLRequest(url: url))
                }
            } catch {
                print("Error while generating PDF: " + error.localizedDescription)
            }
        }
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
