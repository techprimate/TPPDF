//
//  PDFImage.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public class PDFImage: TPJSONSerializable {
    
    var image: UIImage
    var caption: NSAttributedString
    var size: CGSize
    var sizeFit: ImageSizeFit
    
    public init(image: UIImage, caption: NSAttributedString = NSAttributedString(string: ""),
                size: CGSize = .zero, sizeFit: ImageSizeFit = .widthHeight) {
        self.image = image
        self.caption = caption
        self.size = size
        self.sizeFit = sizeFit
    }
}

public enum ImageSizeFit: TPJSONSerializable {
    
    case width, height, widthHeight
    
    // MARK: - JSON Serialization
    
    public var JSONRepresentation: AnyObject {
        return self.hashValue as AnyObject
    }
}
