//
//  PDFGroup.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 31.05.19.
//

#if os(iOS) || os(visionOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

/**
 * Object used to dynamically add multiple elements to a document, but calculate them as one.
 *
 * This way it is possible to add e.g. multiple ``PDFText`` elements and if the calculations require a page break, it can be disabled.
 * Additionally groups allow to set either an ``UIKit.UIColor`` / ``AppKit.NSColor`` as the ``PDFGroup/backgroundColor``
 * or even create a complex ``PDFDynamicGeometryShape`` which adapts to the group frame.
 *
 * **Example:**
 *
 * The following example will create a large text with multiple indentation levels. By setting ``PDFGroup/allowsBreaks`` to `false`,
 * it won't break the text, but move it to the next page in full.
 *
 * ```swift
 * let group = PDFGroup(
 *     allowsBreaks: false,
 *     backgroundColor: .green,
 *     padding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 180)
 * )
 *
 * for i in 0..<10 {
 *     group.set(font: UIFont.systemFont(ofSize: 25))
 *     group.set(indentation: 30 * CGFloat(i % 5), left: true)
 *     group.set(indentation: 30 * CGFloat(i % 3), left: false)
 *     group.add(text: "Text \(i)-\(i)-\(i)-\(i)-\(i)")
 * }
 *
 * document.add(group: group)
 * ```
 *
 * See ``PDFGroupObject/draw(generator:container:in:)`` for internal implementation details
 */
public class PDFGroup {
    // MARK: - PUBLIC VARS

    /// Flag to control if the group should allow page breaks inside, or if it should be moved to the next page in full.
    public var allowsBreaks: Bool

    /**
     * Filling background color in the frame of the group
     *
     * Will be overlayed by ``PDFGroup/backgroundImage`` and ``PDFGroup/backgroundShape``
     */
    public var backgroundColor: Color?

    /**
     * Outline style used if ``PDFGroup/backgroundColor`` is configured.
     *
     * Setting this value without ``PDFGroup/backgroundColor`` will not have any effect.
     */
    public var outline: PDFLineStyle

    /**
     * Filling background image in the frame of the group
     *
     * Will overlay ``PDFGroup/backgroundColor`` and  overlayed by``PDFGroup/backgroundShape``
     */
    public var backgroundImage: PDFImage?

    /**
     * Filling background shape in the frame of the group
     *
     * Will be overlay ``PDFGroup/backgroundColor`` and ``PDFGroup/backgroundImage``
     */
    public var backgroundShape: PDFDynamicGeometryShape?

    /**
     * Inside padding of content to the edge
     *
     * Useful to add a spacing between the content and the ``PDFGroup/outline``
     */
    public var padding: EdgeInsets

    // MARK: - INTERNAL VARS

    /// All objects inside the document and the container they are located in
    var objects: [(PDFGroupContainer, PDFRenderObject)] = []

    // MARK: - PUBLIC INITIALIZERS

    /// Creates a new instance of `PDFGroup` with default configuration
    public init(
        allowsBreaks: Bool = false,
        backgroundColor: Color? = nil,
        backgroundImage: PDFImage? = nil,
        backgroundShape: PDFDynamicGeometryShape? = nil,
        outline: PDFLineStyle = .none,
        padding: EdgeInsets = .zero
    ) {
        self.allowsBreaks = allowsBreaks
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.backgroundShape = backgroundShape
        self.outline = outline
        self.padding = padding
    }

    /// nodoc
    var copy: PDFGroup {
        PDFGroup(
            allowsBreaks: allowsBreaks,
            backgroundColor: backgroundColor,
            backgroundImage: backgroundImage,
            backgroundShape: backgroundShape,
            outline: outline,
            padding: padding
        )
    }
}
