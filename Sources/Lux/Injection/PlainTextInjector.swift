import Foundation

public protocol PlainTextInjector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    func inject(in text: String) -> String
}

extension BaseInjector: PlainTextInjector where Output == String {}
