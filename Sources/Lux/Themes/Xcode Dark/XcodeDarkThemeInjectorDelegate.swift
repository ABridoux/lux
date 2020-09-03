protocol XcodeDarkThemeInjectorDelegate: ThemeInjectorDelegate {}

#if !os(Linux)
extension XcodeDarkThemeInjectorDelegate {
    var themeBackgroundColor: Color { Color.xcodeDark.background }
}
#endif
