public protocol InjectorDelegate {

    /// Inject the given string in the text. The insertion method depends on the category and the text type
    /// - Parameters:
    ///   - category: The category of the match to modify
    ///   - stringtoInject: The string to inject (Css class, terminal color code...)
    ///   - type: The text type: Html or plain
    ///   - text: The text in which to insert the string
    /// - Returns: the modified match with the inserted string
    func inject(_ category: Category, _ stringtoInject: String, in type: TextType, _ text: String) -> String
}

extension InjectorDelegate {

    public func inject(_ category: Category, _ stringtoInject: String, in type: TextType, _ text: String) -> String {
        InjectionService.inject(stringtoInject, in: type, text)
    }
}
