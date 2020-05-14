/// Different text formats which has to be colorised. Plain, Html.
public enum TextType: String {
    case plain, html

    var colorMarkEnd: String {
        switch self {
        case .plain: return Colors.terminalReset
        case .html: return "</span>"
        }
    }
}
