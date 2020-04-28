public protocol XmlDelegate {

    /// Called by the injector to get the string to inject for the given Xml category
    func injection(for category: XMLCategory) -> String
}
