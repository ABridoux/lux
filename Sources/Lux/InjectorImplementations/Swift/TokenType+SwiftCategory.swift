import Splash

extension TokenType {

    var category: SwiftCategory {
        switch self {
        case .keyword: return .keyword
        case .string: return .string
        case .type: return .type
        case .call: return .call
        case .number: return .number
        case .comment: return .comment
        case .property: return .property
        case .dotAccess: return .dotAccess
        case .preprocessing: return .preprocessing
        case .custom(let string): return .custom(string)
        }
    }
}
