import Foundation

open class PlistInjector<Output: Appendable, InjType: InjectorType<Output>>: BaseInjector<PlistCategory, Output, InjType> {

    override var plainRegexPattern: RegexPattern { .plainXml }
    override var htmlRegexPattern: RegexPattern { .htmlXml }

    override public init(type: InjType, delegate: Delegate = PlistDelegate(), languageName: String = "plist") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    override public func inject(in text: String) -> Output {
        var currentOpenTagIsKey = false

        let modifiedInput = try? InjectionService.inject(Output.self, in: text, following: regexPattern) { match in

            let category = getCategory(from: match, currentOpenTagIsKey: &currentOpenTagIsKey)

            return inject(category, in: match)
        }

         guard let output = modifiedInput else {
             assertionFailure("The default regular expression pattern \(regexPattern.stringValue) has failed to build a regular expression")
             return Output(text)
         }

        return output
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
