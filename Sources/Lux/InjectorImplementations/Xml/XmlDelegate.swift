public protocol XmlDelegate {

    /// Call by the injector to get the string to inject for the given Xml category
    func injection(for category: XmlCategory) -> String
}
