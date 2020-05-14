open class InjectorDelegate<Cat: Category> {

    // MARK: - Initialisation

    required public init() {}

    // MARK: - Functions

    /// Called by the injector to get the string color mark to inject for the given category
    open func injection(for category: Cat, type: TextType) -> String {
        switch type {
        case .plain: return category.terminalColor
        case .html: return category.cssClass
        }
    }

    /// Called by the injector to get the color to use for the given category
    open func color(for category: Cat) -> Color { category.color }

    /// Called by the injector to inject the color mark in the match
    /// - Parameters:
    ///   - category: Category of the match where to inject the color mark
    ///   - type: Plain or HTML text
    ///   - match: The string in which to inject the color mark
    /// - Returns: A String which the color mark injected
    open func inject(_ category: Cat, in type: TextType, _ match: String) -> String {
        let stringToInject = injection(for: category, type: type)
        return InjectionService.inject(stringToInject, in: type, match)
    }

    /// Called by the injector to inject the color in a string, returning an `AttributedString`
    /// - Parameters:
    ///   - color: The color to inject
    ///   - category: Category of the match where to inject the color mark
    ///   - match: The string in which to inject the color mark
    /// - Returns: An `AttributedString` with the color set
    open func inject(category: Cat, _ match: String) -> AttributedString {
        let color = self.color(for: category)

        var attrString = AttributedString(match)
        attrString.textColor = color

        return attrString
    }
}
