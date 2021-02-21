import Foundation

/// Injector that can be used to output simple text (not attributed).
public protocol TextInjector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    func inject(in text: String) -> String

    var dataFormat: DataFormat { get }
}

extension ZshInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .zsh }
}

extension SwiftInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .swift }
}

extension XMLInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .xml }
}

extension XMLEnhancedInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .xmlEnhanced }
}

extension PlistInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .plist }
}

extension YAMLInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .yaml }
}

extension JSONInjector: TextInjector where Output == String {
    public var dataFormat: DataFormat { .json }
}
