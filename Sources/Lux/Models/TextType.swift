/// Different text formats which can be used as input text: Plain, Html.
public enum TextType: String {
    case plain, html

    var colorMarkEnd: String {
        switch self {
        case .plain: return TerminalModifier.resetColors.raw
        case .html: return "</span>"
        }
    }

    var openingBracket: String {
        switch self {
        case .plain:
            return "<"
        case .html:
            return "&lt;"
        }
    }

    var closingBracket: String {
        switch self {
        case .plain:
            return ">"
        case .html:
            return "&gt;"
        }
    }
}
