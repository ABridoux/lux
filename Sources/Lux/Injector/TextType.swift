/// Different text formats which has to be colorised. Plain, Html.
public enum TextType: String {
    case plain, html

    /// Escape code to reset the color in the terminal. Used to stop the colorisation.
    static let terminalResetColor = "\u{001B}[0;0m"

    /// Inject a given string into the text. The injection will be different depending on the text type
    /// - Parameters:
    ///   - stringtoInject: The string to inject: a css class, a terminal color...
    ///   - text: The text where to inject
    /// - Returns: The modified text
    public func inject(_ stringtoInject: String, in text: Substring) -> String {
        switch self {
        case .plain:
            return stringtoInject + text + Self.terminalResetColor
        case .html:
            return #"<span class="\#(stringtoInject)">\#(text)</span>"#
        }
    }
}
