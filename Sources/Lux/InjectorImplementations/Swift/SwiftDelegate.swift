import Foundation
import Splash

extension InjectorDelegate where Cat == SwiftCategory {

    var theme: Theme { Theme(
    font: .init(size: 12),
    plainTextColor: .labelColor,
    tokenColors: [
        .keyword: SwiftCategory.keyword.color,
        .string: SwiftCategory.string.color,
        .type: SwiftCategory.type.color,
        .call: SwiftCategory.call.color,
        .number: SwiftCategory.number.color,
        .comment: SwiftCategory.comment.color,
        .property: SwiftCategory.property.color,
        .dotAccess: SwiftCategory.dotAccess.color,
        .preprocessing: SwiftCategory.preprocessing.color,
    ]
    )}
}

open class SwiftDelegate: InjectorDelegate<SwiftCategory> {}
