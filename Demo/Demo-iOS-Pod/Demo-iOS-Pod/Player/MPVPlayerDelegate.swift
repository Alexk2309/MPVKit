import Foundation
import Libmpv

@MainActor
public protocol MPVPlayerDelegate: AnyObject {
    func propertyChange(mpv: OpaquePointer, propertyName: String, data: Any?)
} 