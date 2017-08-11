//
//  PDFImage.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

import Foundation

open class PDFImage {
    
    var image: UIImage
    var caption: NSAttributedString
    var size: CGSize
    var sizeFit: ImageSizeFit
    
    public init(image: UIImage, caption: NSAttributedString = NSAttributedString(string: ""), size: CGSize = .zero, sizeFit: ImageSizeFit = .widthHeight) {
        self.image = image
        self.caption = caption
        self.size = size
        self.sizeFit = sizeFit
    }
}
