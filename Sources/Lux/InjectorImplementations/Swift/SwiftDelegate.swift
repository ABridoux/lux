import Foundation
import Splash

public typealias SwiftDelegate = InjectorDelegate<SwiftCategory>

extension SwiftDelegate {

    var theme: Theme { Theme(
    font: .init(size: 12),
    plainTextColor: Color(red: 1, green: 1, blue: 1, alpha: 1),
    tokenColors: [
        .keyword: SwiftCategory.keyword.color,
        .string: SwiftCategory.string.color,
        .type: SwiftCategory.type.color,
        .call: SwiftCategory.call.color,
        .number: SwiftCategory.number.color,
        .comment: SwiftCategory.comment.color,
        .property: SwiftCategory.property.color,
        .dotAccess: SwiftCategory.dotAccess.color,
        .preprocessing: SwiftCategory.preprocessing.color
    ]
    )}
}

extension SwiftDelegate {
    public static func theme(_ theme: ColorTheme) -> SwiftDelegate {
        switch theme {
        case .dracula: return .dracula
        }
    }
}
