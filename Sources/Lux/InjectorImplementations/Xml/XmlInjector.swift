import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public struct XmlInjector {

    // MARK: - Properties

    var target: RegexPattern
    var delegate: XmlDelegate?

    // MARK: - Functions

    public func inject(in text: String) -> String {
        let modifiedText = try? Injector.inject(in: text, following: target) { match in
            let category = XmlCategory(from: match)
            let stringToInject: String

            if let delegate = self.delegate {
                stringToInject = delegate.injection(for: category)
            } else {
                stringToInject = category.injection(for: self.target.type)
            }

            let modifiedMatch = self.target.type.inject(stringToInject, in: match)

            return modifiedMatch
        }

        guard let finalText = modifiedText else {
            assertionFailure("The default regular expression pattern \(target.stringValue) has failed to build a regular expression")
            return text
        }

        return finalText
    }
}
