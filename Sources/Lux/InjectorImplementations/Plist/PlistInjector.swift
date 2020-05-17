import Foundation

open class PlistInjector: BaseInjector<PlistCategory> {

    override var defaultLanguageIdentifiers: Set<String> { ["plist", "Plist", "PLIST", "language-plist", "language-Plist", "language-PLIST"] }

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: TextType, delegate: BaseInjector<PlistCategory>.Delegate = PlistDelegate()) {
        super.init(type: type, delegate: delegate)
    }

    override open func inject(in text: String) -> String {
        var currentOpenTagIsKey = false

        let modifiedText = try? InjectionService.inject(String.self, in: text, following: regexPattern) { match in

            let category = getCategory(from: match, currentOpenTagIsKey: &currentOpenTagIsKey)
            return delegate.inject(category, in: type, match)
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
             return text
         }

         return finalText
    }

    override open func injectAttributed(in text: String) -> NSMutableAttributedString {
        var currentOpenTagIsKey = false

        let modifiedText = try? InjectionService.inject(AttributedString.self, in: text, following: regexPattern) { match in

            let category = getCategory(from: match, currentOpenTagIsKey: &currentOpenTagIsKey)
            return delegate.inject(category: category, match)
        }

         guard let finalText = modifiedText else {
             assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
             return NSMutableAttributedString(string: text)
         }

        return finalText.nsAttributedString
    }

    func getCategory(from match: String, currentOpenTagIsKey: inout Bool) -> PlistCategory {

        let xmlCategory = XMLCategory(from: match)

        switch xmlCategory {
        case .tag(let tag):
            if tag.contains("plist") {
                // <plist version="1.0"> and </plist> are treated as headers
                return .header
            }

            currentOpenTagIsKey = tag == "key"
            return .tag(tag)

        case .header:
            return .header

        case .comment:
            return .comment

        case .key:
            let category: PlistCategory = currentOpenTagIsKey ? .keyName(match) : .keyValue(match)
            currentOpenTagIsKey = false

            return category

        }
    }
}
