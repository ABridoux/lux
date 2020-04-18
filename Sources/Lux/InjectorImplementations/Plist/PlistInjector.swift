import Foundation

/// Inject strings into a text depending on the configuration or the delegate.
public struct PlistInjector {

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

        let modifiedText = try? Injector.inject(in: text, following: target) { match in
            let xmlCategory = XmlCategory(from: match)
            let category: PlistCategory

            if case let XmlCategory.tag(tag) = xmlCategory {
                category = .tag(tag)
                currentOpenedTagIsKey = tag == "key"
            } else {
                category = currentOpenedTagIsKey ? .keyName(match) : .keyValue(match)
                currentOpenedTagIsKey = false
            }

            let modifiedMatch: String

            if let delegate = self.delegate {
                modifiedMatch = delegate.injection(for: category)
            } else {
                let stringToInject = category.injection(for: self.target.type)
                modifiedMatch = self.target.type.inject(stringToInject, in: match)
            }

            return modifiedMatch
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(target.stringValue) has failed to build a regular expression")
             return text
         }

         return finalText
    }
}
