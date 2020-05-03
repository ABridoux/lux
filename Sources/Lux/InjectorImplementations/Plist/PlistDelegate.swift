public protocol PlistDelegate: InjectorDelegate {

    /// Called by the injector to get the string to inject for the given Plist category
    func injection(for category: PLISTCategory) -> String
}
