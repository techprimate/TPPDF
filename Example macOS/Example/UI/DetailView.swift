//
//  DetailView.swift
//  Example
//
//  Created by Philip Niedertscheider on 24.06.20.
//  Copyright © 2022 techprimate GmbH. All rights reserved.
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

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(example.name)")
                    .font(.headline)
                Spacer()
                Button(action: {
                    self.generatePDF(force: true)
                }, label: {
                    Text("Refresh")
                })
                ProgressBar(value: $progressValue)
                    .frame(width: 100, height: 20)
                    .fixedSize(horizontal: true, vertical: true)
            }.padding(10)

            PDFKitRepresentedView(url: url)
                .onAppear {
                    self.generatePDF(force: false)
                }
        }
    }

    func generatePDF(force: Bool) {
        if url != nil && !force {
            return
        }
        let docs = example.factory.generateDocument()
        if docs.count == 1 {
            generator = PDFGenerator(document: docs[0])
        } else {
            generator = PDFMultiDocumentGenerator(documents: docs)
        }
        generator.debug = true

        observer = generator.progress.observe(\.completedUnitCount) { progress, _ in
            self.progressValue = progress.fractionCompleted
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let url = try self.generator.generateURL(filename: "output.pdf")
                DispatchQueue.main.async {
                    self.url = url
                }
            } catch {
                print("Error while generating PDF: " + error.localizedDescription)
            }
        }
    }
}
