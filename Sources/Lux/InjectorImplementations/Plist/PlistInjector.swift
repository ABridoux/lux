import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public struct PlistInjector: Injector {

    // MARK: - Constants

    public var languageIdentifiers: Set<String> = ["plist", "Plist", "PLIST", "language-plist", "language-Plist", "language-PLIST"]

    // MARK: - Properties

    public var target: RegexPattern
    public var delegate: PlistDelegate?

    // MARK: - Initialisation

    public init(type: TextType, delegate: PlistDelegate? = nil) {
        switch type {
        case .plain: target = .plainXml
        case .html: target = .htmlXml
        }
        self.delegate = delegate
    }

    // MARK: - Functions

    public func inject(in text: String) -> String {
        var currentOpenedTagIsKey = false

        let modifiedText = try? InjectionService.inject(String.self, in: text, following: target) { match in
            let xmlCategory = XMLCategory(from: match)
            let category: PlistCategory

            if case let XMLCategory.tag(tag) = xmlCategory {
                category = .tag(tag)
                currentOpenedTagIsKey = tag == "key"
            } else {
                category = currentOpenedTagIsKey ? .keyName(match) : .keyValue(match)
                currentOpenedTagIsKey = false
            }

            let stringToInject: String

            if let delegate = self.delegate {
                stringToInject = delegate.injection(for: category)
                return delegate.inject(stringToInject, in: target.type, match)
            } else {
                stringToInject = category.injection(for: self.target.type)
                return InjectionService.inject(stringToInject, in: target.type, match)
            }
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(target.stringValue) has failed to build a regular expression")
             return text
         }

         return finalText
    }

    public func injectAttributed(in text: String) -> NSMutableAttributedString {
        var currentOpenedTagIsKey = false

        let modifiedText = try? InjectionService.inject(AttributedString.self, in: text, following: target) { match in
            let xmlCategory = XMLCategory(from: match)
            let category: PlistCategory

            if case let XMLCategory.tag(tag) = xmlCategory {
                category = .tag(tag)
                currentOpenedTagIsKey = tag == "key"
            } else {
                category = currentOpenedTagIsKey ? .keyName(match) : .keyValue(match)
                currentOpenedTagIsKey = false
            }

            let color = category.color
            let attrString = category.inject(color: color, in: match)
            return attrString
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(target.stringValue) has failed to build a regular expression")
            return NSMutableAttributedString(string: text)
         }

        return finalText.attrString
    }
}
