import Foundation

extension Bundle {
    private static var productsDirectory: URL {
        #if os(macOS)
            if let bundle = Bundle.allBundles.first(where: { $0.bundlePath.hasSuffix(".xctest") }) {
                return bundle.bundleURL.deletingLastPathComponent()
            }
            fatalError("Couldn't find the products directory")
        #else
            return Bundle.main.bundleURL
        #endif
    }

    static var module: Bundle = .main
}
