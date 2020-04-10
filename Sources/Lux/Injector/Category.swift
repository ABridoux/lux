/// Represents the different elements composing a data format. For example for Xml it would be an enum with two cases: `key` and `tag`
public protocol Category {

    var cssClass: String { get }
    var terminalColor: String { get }
}

extension Category {
    public func injection(for type: TextType) -> String {
        switch type {
        case .plain: return terminalColor
        case .html: return cssClass
        }
    }
}
