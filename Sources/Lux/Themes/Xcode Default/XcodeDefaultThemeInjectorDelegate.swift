protocol XcodeDefaultThemeInjectorDelegate: ThemeInjectorDelegate {}

extension XcodeDefaultThemeInjectorDelegate {
    var themeBackgroundColor: Color { Color.xcodeLight.background }
}
