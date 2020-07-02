public typealias PlistDelegate = InjectorDelegate<PlistCategory>

extension PlistDelegate {
    public static func theme(_ theme: ColorTheme) -> PlistDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        }
    }
}
