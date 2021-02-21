import Foundation

/// Injector that can be used to output simple text (not attributed).
public protocol TextInjector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    func inject(in text: String) -> String

    var dataFormat: DataFormat { get }
}

extension BaseInjector: TextInjector where Output == String {}
