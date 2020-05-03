import Foundation

public protocol JSONDelegate: InjectorDelegate {

    /// Called by the injector to get the string to inject for the given Json category
    func injection(for category: JSONCategory) -> String
}

extension JSONDelegate {

    public func inject(_ category: Category, _ stringtoInject: String, in type: TextType, _ text: String) -> String {
        guard let category = category as? JSONCategory else {
            assertionFailure("Trying to inject a non JSONCategory in a Json format text")
            return text
        }

        return category.inject(in: type, text)
    }
}
