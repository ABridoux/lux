public typealias JSONDelegate = InjectorDelegate<JSONCategory>

extension JSONDelegate {
    public static func theme(_ theme: ColorTheme) -> JSONDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        }
    }
}
