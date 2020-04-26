/// Represents the different elements composing a data format. For example for Xml it would be an enum with two cases: `key` and `tag`
public protocol Category {
    var cssClass: String { get }
    var terminalColor: String { get }

    func injection(for type: TextType) -> String

    /// Inject a given string into the text. The injection will be different depending on the text type
    /// - Parameters:
    ///   - stringtoInject: The string to inject: a css class, a terminal color...
    ///   - text: The text where to inject
    /// - Returns: The modified text
    func inject(_ stringtoInject: String, in type: TextType, _ text: Substring) -> String
}

extension Category {

    // MARK: - Constants
    /// Escape code to reset the color in the terminal. Used to stop the colorisation.
    static var terminalResetColor: String { "\u{001B}[0;0m" }

    // MARK: - Functions

    /// - Parameter type: Plain or HTML text
    /// - Returns: The string to inject for the given category
    public func injection(for type: TextType) -> String {
        switch type {
        case .plain: return terminalColor
        case .html: return cssClass
        }
    }

    /// Inject the given string in the text. The insertion method depends on the category and the text type
    /// - Parameters:
    ///   - stringtoInject: The string to inject (Css class, terminal color code...)
    ///   - type: The text type: Html or plain
    ///   - text: The text in which to insert the string
    /// - Returns: the modified match with the inserted string
    public func inject(_ stringtoInject: String, in type: TextType, _ text: Substring) -> String {
        switch type {
        case .plain:
            return stringtoInject + text + Self.terminalResetColor
        case .html:
            return #"<span class="\#(stringtoInject)">\#(text)</span>"#
        }
    }
}
