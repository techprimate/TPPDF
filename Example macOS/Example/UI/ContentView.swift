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
    @State var selectedFactory = Examples.defaultFactory

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(Examples.factories, id: \.header) { section in
                    Section(header: Text(section.header)) {
                        ForEach(section.examples, id: \.name) { example in
                            NavigationLink(example.name, destination: DetailView(example: example))
                        }
                    }
                }
            }
            .frame(minWidth: 100, idealWidth: 200, maxWidth: 300,
                   minHeight: 0, maxHeight: .infinity,
                   alignment: .topLeading)
            .listStyle(SidebarListStyle())

            DetailView(example: viewModel.selectedFactory)
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity,
                       alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
