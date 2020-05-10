/// Represents the different elements composing a data format. For example for Xml it would be an enum with two cases: `key` and `tag`
public protocol Category {

    var cssClass: String { get }
    var terminalColor: String { get }
    var color: Color { get }

    func injection(for type: TextType) -> String
    func inject(color: Color, in text: String) -> AttributedString
}

extension Category {

    // MARK: - Functions

    /// - Parameter type: Plain or HTML text
    /// - Returns: The string to inject for the given category
    public func injection(for type: TextType) -> String {
        switch type {
        case .plain: return terminalColor
        case .html: return cssClass
        }
    }

    public func inject(color: Color, in text: String) -> AttributedString {
        var attrString = AttributedString(text)
        attrString.textColor = color

        return attrString
    }
}
