import CoreGraphics

/// Constants used throught the framework
public enum PDFConstants {
    /**
     * Default font size for objects
     *
     * In earlier versions the default ``UIFont.systemFontSize`` was used, but during implementation of macOS support,
     * findings showed that it differs to``NSFont.systemFontSize``. Therefore the new default font size is declared here.
     */
    public static let defaultFontSize: CGFloat = 17
}
