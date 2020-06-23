//
//  ContentView.swift
//  Example
//
//  Created by Philip Niedertscheider on 23.06.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import SwiftUI
import Combine
import TPPDF

class ContentViewModel: ObservableObject {

    @Published var url: URL?
    @State var selectedFactory = Examples.factories.first?.facts.first {
        didSet {
            generate()
        }
    }

    func generate() {
        print("generate")
    }
}

struct DetailView: View {

    @State var name: String
    @State var factory: ExampleFactory
    @State var generator: PDFGeneratorProtocol!
    @State var url: URL?

    var body: some View {
        PDFKitRepresentedView(url: url)
            .onAppear {
                self.generatePDF()
        }
    }

    func generatePDF() {
        let docs = factory.generateDocument()
        if docs.count == 1 {
            generator = PDFGenerator(document: docs[0])
        } else {
            generator = PDFMultiDocumentGenerator(documents: docs)
        }
        generator.debug = true

//        observer = generator.progress.observe(\.completedUnitCount) { (p, v) in
//            DispatchQueue.main.async {
//                self.progressView.doubleValue = p.fractionCompleted
//            }
//        }
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

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(Examples.factories, id: \.header) { item in
                    Section(header: Text(item.header)) {
                        ForEach(item.facts, id: \.0) { factory in
                            NavigationLink(factory.0, destination: DetailView(name: factory.0, factory: factory.1))
                        }
                    }
                }
            }
            .frame(minWidth: 150, maxWidth: 150, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .listStyle(SidebarListStyle())

            DetailView(name: viewModel.selectedFactory!.0, factory: viewModel.selectedFactory!.1)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.viewModel.generate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
