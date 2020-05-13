public protocol PlistDelegate {

    /// Called by the injector to get the string to inject for the given Plist category
    func injection(for category: PlistCategory) -> String

    func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String
}

public extension PlistDelegate {

    func inject(_ stringToInject: String, in type: TextType, _ text: String) -> String {
        InjectionService.inject(stringToInject, in: type, text)
    }
}
