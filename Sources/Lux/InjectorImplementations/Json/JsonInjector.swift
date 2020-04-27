import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public struct JSONInjector {

    // MARK: - Properties

    /// All Json reserved characters are treated as literal in HTML
    public let type: TextType
    public var delegate: JSONDelegate?

    // MARK: - Initialisation

    public init(type: TextType, delegate: JSONDelegate? = nil) {
        self.type = type
        self.delegate = delegate
    }

    // MARK: - Functions

    public func inject(in text: String) -> String {
        let modifiedText = try? InjectionService.inject(in: text, following: .json) { match, _ in
            let category = JSONCategory(from: match)
            let stringToInject: String

            if let delegate = self.delegate {
                stringToInject = delegate.injection(for: category)
            } else {
                stringToInject = category.injection(for: self.type)
            }

            return category.inject(stringToInject, in: type, match)
        }

        guard let finalText = modifiedText else {
            assertionFailure("The default regular expression pattern \(RegexPattern.json.stringValue) has failed to build a regular expression")
            return text
        }

        return finalText
    }
}
