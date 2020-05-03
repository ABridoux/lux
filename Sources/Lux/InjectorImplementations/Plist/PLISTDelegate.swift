public protocol PLISTDelegate {

    /// Called by the injector to get the string to inject for the given Plist category
    func injection(for category: PLISTCategory) -> String

    func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String
}

public extension PLISTDelegate {

    func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String {
        InjectionService.inject(stringToInject, in: type, text)
    }
}
