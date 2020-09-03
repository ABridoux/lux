import Foundation
import Splash

public typealias SwiftDelegate = InjectorDelegate<SwiftCategory>

#if !os(Linux)
extension SwiftDelegate {

    var theme: Theme { Theme(
    font: .init(size: 12),
    plainTextColor: color(for: .plainText),
    tokenColors: [
        .keyword: color(for: .keyword),
        .string: color(for: .string),
        .type: color(for: .type),
        .call: color(for: .call),
        .number: color(for: .number),
        .comment: color(for: .comment),
        .property: color(for: .property),
        .dotAccess: color(for: .dotAccess),
        .preprocessing: color(for: .preprocessing)
    ]
    )}
}
#endif

extension SwiftDelegate {
    public static func theme(_ theme: ColorTheme) -> SwiftDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        case .xcodeDark: return .xcodeDark
        }
    }
}
