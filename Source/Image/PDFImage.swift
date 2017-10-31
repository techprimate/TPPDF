//
//  PDFImage.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//
//

public class PDFImage: TPJSONSerializable {
    
    public var image: UIImage
    public var caption: NSAttributedString?
    public var size: CGSize
    public var sizeFit: ImageSizeFit
    public var quality: CGFloat
    
    public init(image: UIImage,
                caption: NSAttributedString? = nil,
                size: CGSize = .zero,
                sizeFit: ImageSizeFit = .widthHeight,
                quality: CGFloat = 0.85) {
        self.image = image
        self.caption = caption
        self.size = size
        self.sizeFit = sizeFit
        self.quality = quality
    }
}

public enum ImageSizeFit: TPJSONSerializable {
    
    case width, height, widthHeight
    
    // MARK: - JSON Serialization
    
    public var JSONRepresentation: AnyObject {
        return self.hashValue as AnyObject
    }
}
