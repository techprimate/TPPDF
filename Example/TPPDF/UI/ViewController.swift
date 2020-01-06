//
//  ViewController.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 08.11.16.
//  Copyright © 2019 Philip Niedertscheider. All rights reserved.
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
        print("Preparation took: " + TimeUtils.stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
        startTime = CFAbsoluteTimeGetCurrent()
        /* ---- Execution Metrics ---- */
        
        var generator: PDFGeneratorProtocol
        if documents.count > 1 {
            generator = PDFMultiDocumentGenerator(documents: documents)
        } else {
            generator = PDFGenerator(document: documents.first!)
        }
        generator.debug = exampleFactory is ExperimentFactory

        self.progressView.observedProgress = generator.progress
        observer = generator.progress.observe(\.completedUnitCount) { (p, _) in
            print(p.localizedDescription ?? "")
        }
        DispatchQueue.global(qos: .background).async {
            do {
                let url = try generator.generateURL(filename: "Example.pdf")
                print("Output URL:", url)

                /* ---- Execution Metrics ---- */
                print("Generation took: " + TimeUtils.stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
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
}
