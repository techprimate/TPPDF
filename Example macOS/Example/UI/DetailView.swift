//
//  DetailView.swift
//  Example
//
//  Created by Philip Niedertscheider on 24.06.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import TPPDF
import SwiftUI

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
                ProgressBar(value: $progressValue)
                    .frame(width: 100, height: 20)
                    .fixedSize(horizontal: true, vertical: true)
            }.padding(10)

            PDFKitRepresentedView(url: url)
                .onAppear {
                    self.generatePDF()
            }
        }
    }

    func generatePDF() {
        guard !isGenerated else {
            return
        }
        let docs = example.factory.generateDocument()
        if docs.count == 1 {
            generator = PDFGenerator(document: docs[0])
        } else {
            generator = PDFMultiDocumentGenerator(documents: docs)
        }
        generator.debug = false

        observer = generator.progress.observe(\.completedUnitCount) { (p, v) in
            self.progressValue = p.fractionCompleted
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
