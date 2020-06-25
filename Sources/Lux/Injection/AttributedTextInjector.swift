import Foundation

public protocol AttributedTextInjector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    func inject(in text: String) -> AttributedString
}

extension BaseInjector: AttributedTextInjector where Output == AttributedString {}
