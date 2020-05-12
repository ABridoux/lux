public protocol XMLDelegate {

    /// Called by the injector to get the string to inject for the given Xml category
    func injection(for category: XMLCategory) -> String

    func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String
}

extension XMLDelegate {

    public func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String {
        InjectionService.inject(stringToInject, in: type, text)
    }
}
