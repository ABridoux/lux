import Foundation

public protocol Injector {

    /// Set of language identifier strings used in css and html files code blocks
    /// - Note: Add strings to this set to match new identifiers not already present in it
    var languageIdentifiers: Set<String> { get set }

    /// Inject the color marks in the given text, then returns it
    func inject(in text: String) -> String

    /// Transform the text to a `NSMutableAttributedString` composed of multiple `NSMutableAttributedString`s, each with the right color attribute
    func injectAttributed(in text: String) -> NSMutableAttributedString
}
