//
//  ContentView.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 23.06.2020.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import SwiftUI
import TPPDF

struct ContentView: View {
    var body: some View {
        #if os(watchOS) || os(tvOS)
        NavigationStack {
            examplesList
        }
        #else
        NavigationView {
            examplesList
            #if os(macOS)
            .frame(minWidth: 200, idealWidth: 250, maxWidth: 300)
            .listStyle(SidebarListStyle())
            #endif

            DetailView(example: Examples.defaultFactory)
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: .infinity,
                       alignment: .topLeading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        #endif
    }

    private var examplesList: some View {
        List {
            ForEach(Examples.factories, id: \.header) { section in
                Section(header: Text(section.header)) {
                    ForEach(section.examples, id: \.name) { example in
                        NavigationLink(example.name, destination: DetailView(example: example))
                    }
                }
            }
        }
        .navigationTitle("Examples")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
