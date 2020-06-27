//
//  ProgressBar.swift
//  Example
//
//  Created by Philip Niedertscheider on 24.06.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading)  {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(.systemTeal))

                Rectangle()
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width),
                           height: geometry.size.height)
                    .foregroundColor(Color(.systemBlue))
                    .animation(.linear)
            }.cornerRadius(min(geometry.size.height, geometry.size.width) / 2)
        }
    }
}
