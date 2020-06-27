public typealias ZshDelegate = InjectorDelegate<ZshCategory>

extension ZshDelegate {
    public static func theme(_ theme: ColorTheme) -> ZshDelegate {
        switch theme {
        case .dracula: return .dracula
        }
    }
}
