public typealias XMLEnhancedDelegate = InjectorDelegate<XMLEnhancedCategory>

extension XMLEnhancedDelegate {
    public static func theme(_ theme: ColorTheme) -> XMLEnhancedDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        }
    }
}
