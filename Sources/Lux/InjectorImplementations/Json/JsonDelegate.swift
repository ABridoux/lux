public protocol JSONDelegate {

    /// Called by the injector to get the string to inject for the given Json category
    func injection(for category: JSONCategory) -> String
}
