//
//  DetailView.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 24.06.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import SwiftUI
import TPPDF

struct DetailView: View {
    let example: Example
    @State private var url: URL?
    @State private var observer: NSKeyValueObservation?
    @State private var progressValue: Double = 0
    @State private var isGenerating = false
    @State private var errorMessage: String?
    @State private var debug = false

    var body: some View {
        #if os(watchOS)
        ScrollView {
            detailContent
        }
        #else
        detailContent
        #endif
    }

    private var detailContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(example.name)
                .font(.headline)

            #if os(watchOS)
            VStack {
                generationControls
            }
            #else
            HStack {
                generationControls
            }
            #endif

            if let errorMessage = errorMessage {
                Text("Generation failed: \(errorMessage)")
                    .foregroundColor(.red)
            }

            #if os(watchOS)
            if let url = url {
                Text("PDF generated")
                Text(url.lastPathComponent)
                    .font(.caption)
                    .lineLimit(2)
            } else if isGenerating {
                Text("Generating PDF…")
            }
            #else
            PDFKitRepresentedView(url: url)
            #endif
        }
        .padding(10)
        .onAppear {
            generatePDF(force: false, debug: debug)
        }
    }

    @ViewBuilder
    private var generationControls: some View {
        Toggle("Debug Mode", isOn: Binding(
            get: { debug },
            set: { value in
                debug = value
                generatePDF(force: true, debug: value)
            }
        ))
        .disabled(isGenerating)
        Button("Refresh") {
            generatePDF(force: true, debug: debug)
        }
        .disabled(isGenerating)
        ProgressView(value: progressValue)
    }

    private func generatePDF(force: Bool, debug: Bool) {
        guard !isGenerating, url == nil || force else {
            return
        }
        isGenerating = true
        errorMessage = nil
        progressValue = 0

        let documents = example.factory.generateDocument()
        var generator: PDFGeneratorProtocol
        if documents.count == 1 {
            generator = PDFGenerator(document: documents[0])
        } else {
            generator = PDFMultiDocumentGenerator(documents: documents)
        }
        generator.debug = debug

        observer = generator.progress.observe(\.completedUnitCount) { progress, _ in
            let value = progress.fractionCompleted
            DispatchQueue.main.async {
                progressValue = value
            }
        }

        DispatchQueue.global(qos: .background).async {
            do {
                let generatedURL = try generator.generateURL(filename: "output-\(UUID().uuidString).pdf")
                DispatchQueue.main.async {
                    url = generatedURL
                    progressValue = 1
                    isGenerating = false
                }
            } catch {
                let message = error.localizedDescription
                DispatchQueue.main.async {
                    errorMessage = message
                    isGenerating = false
                }
            }
        }
    }
}
