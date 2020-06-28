//
//  GroupExampleFactory.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 techprimate GmbH & Co. KG. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import TPPDF

class GroupExampleFactory: ExampleFactory {

    func generateDocument() -> [PDFDocument] {
        let document = PDFDocument(format: .a4)

        // Create sample bezier path
        let size = CGSize(width: 100, height: 100)
        let path = PDFBezierPath(ref: CGRect(origin: .zero, size: size))
        path.move(to: PDFBezierPathVertex(position: CGPoint(x: size.width / 2, y: 0), anchor: .topCenter))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: size.width, y: size.height / 2),
                                             anchor: .middleRight))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: size.width / 2, y: size.height),
                                             anchor: .bottomCenter))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: 0, y: size.height / 2),
                                             anchor: .middleLeft))
        path.close()

        // Create a dynamic shape using the defined cache in reference to its size
        let shape = PDFDynamicGeometryShape(path: path, fillColor: .orange, stroke: .none)

        // Create the group object and set the background color and shape
        let group = PDFGroup(allowsBreaks: false,
                             backgroundColor: .green,
                             backgroundShape: shape,
                             padding: EdgeInsets(top: 50, left: 50, bottom: 50, right: 180))
        for i in 0..<10 {
            group.set(font: Font.systemFont(ofSize: 18))
            group.set(indentation: 30 * CGFloat(i % 5), left: true)
            group.set(indentation: 30 * CGFloat(i % 3), left: false)
            group.add(text: "Text \(i)-\(i)-\(i)-\(i)-\(i)")
        }
        document.add(group: group)

        return [document]
    }
}
