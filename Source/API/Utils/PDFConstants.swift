import CoreGraphics

/// Constants used throught the framework
public class PDFConstants {

    /// Default font size for objects
    ///
    /// In earlier versions the default `UIFont.systemFontSize` was used, but during implementation of macOS support, findings showed that it `NSFont.systemFontSize` differs. Therefore the new default fontSize is declared here
    public static let defaultFontSize: CGFloat = 17
}
