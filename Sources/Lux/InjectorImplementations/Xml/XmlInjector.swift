import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public struct XmlInjector {

    // MARK: - Properties

    public var target: RegexPattern
    public var delegate: XmlDelegate?

    // MARK: - Initialisation

    public init(type: TextType, delegate: XmlDelegate? = nil) {
        switch type {
        case .plain: target = .plainXml
        case .html: target = .htmlXml
        }
        self.delegate = delegate
    }

    // MARK: - Functions

    public func inject(in text: String) -> String {
        let modifiedText = try? InjectionService.inject(in: text, following: target) { match, _ in
            let category = XMLCategory(from: match)
            let stringToInject: String

            if let delegate = self.delegate {
                stringToInject = delegate.injection(for: category)
            } else {
                stringToInject = category.injection(for: self.target.type)
            }

            return category.inject(stringToInject, in: target.type, match)
        }

        guard let finalText = modifiedText else {
            assertionFailure("The default regular expression pattern \(target.stringValue) has failed to build a regular expression")
            return text
        }

        return finalText
    }
}
