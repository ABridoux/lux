import Foundation

public protocol JSONDelegate {

    /// Called by the injector to get the string to inject for the given Json category
    func injection(for category: JSONCategory, textType: TextType) -> String

    func inject(_ category: JSONCategory, _ stringToInject: String, in type: TextType, _ text: String) -> String
}

extension JSONDelegate {

    func injection(for category: JSONCategory, textType: TextType) -> String { category.injection(for: textType) }

    public func inject(_ category: JSONCategory, _ stringToInject: String, in type: TextType, _ text: String) -> String {
        return category.inject(in: type, text)
    }
}
