//
// Scout
// Copyright (c) Alexis Bridoux 2020
// MIT license, see LICENSE file for details

import Foundation

extension RegexPattern {
    static let yaml = RegexPattern(#"(?<=(^|\s))-|[^\s]{1}.*:(?=\s)"#, type: .plain)
}

public final class YAMLInjector<Output: Appendable, Injection: InjectionType, InjType: InjectorType<Output, Injection>>: BaseInjector<YAMLCategory, Output, Injection, InjType> {

    // MARK: - Properties

    override var plainRegexPattern: RegexPattern { .yaml }
    override var htmlRegexPattern: RegexPattern { .yaml }

    // MARK: - Initialisation

    override public init(type: InjType, delegate: Delegate = YAMLDelegate(), languageName: String = "yaml") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    // MARK: - Functions

    override func inject(_ category: YAMLCategory, in match: String) -> Output {

        switch category {
        case .punctuation, .keyValue: return delegate.inject(category, in: type, match)
        case .keyName:
            var match = match
            guard let lastTwoPoints = match.popLast() else {
                assertionFailure("Unable to remove last two points of a YAML key name")
                return delegate.inject(category, in: type, match)
            }

            var output = delegate.inject(.keyName, in: type, match)
            output += delegate.inject(.punctuation, in: type, String(lastTwoPoints))

            return output
        }
    }
}
