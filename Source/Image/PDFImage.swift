//
//  PDFImage.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/2017.
//

/**
 Image element for the PDF document. Contains all information about an image, including the caption.
 */
public class PDFImage: PDFJSONSerializable {

    /**
     The actual image
     */
    public var image: UIImage

    /**
     An instance of a `PDFText` subclass.
     Use `PDFSimpleText` for a simple, container-based styled caption and `PDFAttributedText` for advanced styling.
     */
    public var caption: PDFText?

    /**
     The size of the image in the PDF document
     */
    public var size: CGSize

    /**
     Defines how the image will fit if not enough space is given
     */
    public var sizeFit: PDFImageSizeFit

    /**
     JPEG quality of image.

     Value ranges between 0.0 and 1.0, maximum quality equals 1.0
     */
    public var quality: CGFloat

    /**

    */
    public var options: PDFImageOptions

    /**
     Initializer to create a PDF image element.

     - parameter image: Image which will be drawn
     - parameter caption: Optional instance of a `PDFText` subclass, defaults to `nil`
     - parameter size: Size of image, defaults to zero size
     - parameter sizeFit: Defines how the image will fit if not enough space is given, defaults to `PDFImageSizeFit.widthHeight`
     - parameter quality: JPEG quality between 0.0 and 1.0, defaults to 0.85
     */
    public init(image: UIImage,
                caption: PDFText? = nil,
                size: CGSize = .zero,
                sizeFit: PDFImageSizeFit = .widthHeight,
                quality: CGFloat = 0.85,
                options: PDFImageOptions = [.resize, .compress]) {
        self.image = image
        self.caption = caption
        self.size = (size == .zero) ? image.size : size
        self.sizeFit = sizeFit
        self.quality = quality
        self.options = options
    }

    var copy: PDFImage {
        return PDFImage(image: self.image,
                        caption: self.caption?.copy,
                        size: self.size,
                        sizeFit: self.sizeFit,
                        quality: self.quality,
                        options: self.options)
    }
}
