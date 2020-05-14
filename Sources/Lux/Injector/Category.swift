/// Represents the different elements composing a data format. For example for Xml it would be an enum with two cases: `key` and `tag`
public protocol Category {

    var cssClass: String { get }
    var terminalColor: String { get }
    var color: Color { get }

    init(from match: String)
}
