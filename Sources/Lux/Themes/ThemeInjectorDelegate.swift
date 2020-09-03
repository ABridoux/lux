/// An InjectorDelegate for a theme
protocol ThemeInjectorDelegate {
    #if !os(Linux)
    var themeBackgroundColor: Color { get }
    #endif
}
