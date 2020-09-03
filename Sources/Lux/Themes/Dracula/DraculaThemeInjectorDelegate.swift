protocol DraculaThemeInjectorDelegate: ThemeInjectorDelegate {}

#if !os(Linux)
extension DraculaThemeInjectorDelegate {
    var themeBackgroundColor: Color { Color.dracula.background }
}
#endif
