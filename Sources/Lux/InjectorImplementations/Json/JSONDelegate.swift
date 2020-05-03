import Foundation

public protocol JSONDelegate {

    /// Called by the injector to get the string to inject for the given Json category
    func injection(for category: JSONCategory) -> String
    func inject(_ category: JSONCategory, _ stringToInject: String, in type: TextType, _ text: String) -> String
}

public extension JSONDelegate {

    func inject(_ category: JSONCategory, _ stringToInject: String, in type: TextType, _ text: String) -> String {
        return category.inject(in: type, text)
    }
}
