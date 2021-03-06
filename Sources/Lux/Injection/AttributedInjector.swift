import Foundation

/// Injector that can be used to output attributed strings
public protocol AttributedInjector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    #if !os(Linux)
    /// Color of the background to be used with the Injector
    var backgroundColor: Color { get }
    #endif

    func inject(in text: String) -> AttributedString
}

extension BaseInjector: AttributedInjector where Output == AttributedString {}
