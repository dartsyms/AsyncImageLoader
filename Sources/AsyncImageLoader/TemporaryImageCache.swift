import SwiftUI
#if !os(macOS)
import UIKit
#endif

// TODO: persistence between launches

public protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

public struct TemporaryImageCache: ImageCache {
    private let storage = NSCache<NSURL, UIImage>()
    
    public subscript(_ key: URL) -> UIImage? {
        get {
            storage.object(forKey: key as NSURL)
        }
        set {
            newValue == nil ? storage.removeObject(forKey: key as NSURL) : storage.setObject(newValue!, forKey: key as NSURL)
        }
    }
}

public struct ImageCacheKey: EnvironmentKey {
    public static let defaultValue: ImageCache = TemporaryImageCache()
}

