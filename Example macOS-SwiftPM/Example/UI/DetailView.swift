//
//  DetailView.swift
//  Example
//
//  Created by Philip Niedertscheider on 24.06.2020.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import SwiftUI
import TPPDF

struct DetailView: View {
    @State var example: Example
    @State var generator: PDFGeneratorProtocol!
    @State var isGenerated = false
    @State var url: URL?

    @State var observer: NSObjectProtocol! = nil
    @State var progressValue: Double = 0.5

    @State var debug = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(example.name)")
                    .font(.headline)
                Toggle(isOn: $debug) {
                    Text("Debug Mode")
                }
                .onChange(of: debug) { debug in
                    self.generatePDF(force: true, debug: debug)
                }
                Spacer()
                Button(action: {
                    self.generatePDF(force: true, debug: debug)
                }, label: {
                    Text("Refresh")
                })
                ProgressBar(value: $progressValue)
                    .frame(width: 100, height: 20)
                    .fixedSize(horizontal: true, vertical: true)
            }.padding(10)

            PDFKitRepresentedView(url: url)
                .onAppear {
                    self.generatePDF(force: false, debug: debug)
                }
        }
    }

    func generatePDF(force: Bool, debug: Bool) {
        if url != nil && !force {
            return
        }
        let docs = example.factory.generateDocument()
        if docs.count == 1 {
            generator = PDFGenerator(document: docs[0])
        } else {
            generator = PDFMultiDocumentGenerator(documents: docs)
        }
        generator.debug = debug

        observer = generator.progress.observe(\.completedUnitCount) { progress, _ in
            self.progressValue = progress.fractionCompleted
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let url = try self.generator.generateURL(filename: "output-\(UUID().uuidString).pdf")
                DispatchQueue.main.async {
                    self.url = url
                }
            } catch {
                print("Error while generating PDF: " + error.localizedDescription)
            }
        }
    }
}
