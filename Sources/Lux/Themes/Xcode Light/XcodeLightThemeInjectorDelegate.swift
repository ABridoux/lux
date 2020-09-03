protocol XcodeLightThemeInjectorDelegate: ThemeInjectorDelegate {}

extension XcodeLightThemeInjectorDelegate {
    #if !os(Linux)
    var themeBackgroundColor: Color { Color.xcodeLight.background }
    #endif
}
