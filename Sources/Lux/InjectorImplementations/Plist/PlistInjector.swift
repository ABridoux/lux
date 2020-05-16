import Foundation

open class PlistInjector: BaseInjector<PlistCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["plist", "Plist", "PLIST", "language-plist", "language-Plist", "language-PLIST"] }

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: TextType, delegate: BaseInjector<PlistCategory>.Delegate = PlistDelegate()) {
        super.init(type: type, delegate: delegate)
    }

    override open func inject(in text: String) -> String {
        var currentOpenedTagIsKey = false

        let modifiedText = try? InjectionService.inject(String.self, in: text, following: regexPattern) { match in
            let xmlCategory = XMLCategory(from: match)
            let category: PlistCategory

            if case let XMLCategory.tag(tag) = xmlCategory {
                category = .tag(tag)
                currentOpenedTagIsKey = tag == "key"
            } else {
                category = currentOpenedTagIsKey ? .keyName(match) : .keyValue(match)
                currentOpenedTagIsKey = false
            }

            return delegate.inject(category, in: type, match)
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
             return text
         }

         return finalText
    }

    override open func injectAttributed(in text: String) -> NSMutableAttributedString {
        var currentOpenedTagIsKey = false

        let modifiedText = try? InjectionService.inject(AttributedString.self, in: text, following: regexPattern) { match in
            let xmlCategory = XMLCategory(from: match)
            let category: PlistCategory

            if case let XMLCategory.tag(tag) = xmlCategory {
                category = .tag(tag)
                currentOpenedTagIsKey = tag == "key"
            } else {
                category = currentOpenedTagIsKey ? .keyName(match) : .keyValue(match)
                currentOpenedTagIsKey = false
            }

            return delegate.inject(category: category, match)
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
             return NSMutableAttributedString(string: text)
         }

        return finalText.nsAttributedString
    }
}
