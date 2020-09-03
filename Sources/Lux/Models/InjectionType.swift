#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

/// Types of injection an injector can use: `Color`, `TerminalModifier` and `CssClass`
public protocol InjectionType {

    /// Empty injection
    static func none() -> Self
}

extension String: InjectionType {
    public static func none() -> String { "" }
}

#if os(iOS)
extension UIColor: InjectionType {
    public static func none() -> Self { Self() }
}

#elseif os(macOS)

extension NSColor: InjectionType {
    public static func none() -> Self { Self() }
}
#endif

extension TerminalModifier: InjectionType {
    public static func none() -> TerminalModifier { TerminalModifier.resetColors }
}
