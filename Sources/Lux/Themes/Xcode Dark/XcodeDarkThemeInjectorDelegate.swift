protocol XcodeDarkThemeInjectorDelegate: ThemeInjectorDelegate {}

extension XcodeDarkThemeInjectorDelegate {
    var themeBackgroundColor: Color { Color.xcodeDark.background }
}
