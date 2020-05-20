/// Different text formats which has to be colorised. Plain, Html.
public enum TextType: String {
    case plain, html

    var colorMarkEnd: String {
        switch self {
        case .plain: return Colors.terminalReset
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
