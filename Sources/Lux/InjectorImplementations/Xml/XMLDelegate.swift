public typealias XMLDelegate = InjectorDelegate<XMLCategory>

extension XMLDelegate {
    public static func theme(_ theme: ColorTheme) -> XMLDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        }
    }
}
