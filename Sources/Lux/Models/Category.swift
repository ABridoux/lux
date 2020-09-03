/// Represents the different elements composing a data format. For example for Xml it would be an enum with two cases: `key` and `tag`, while it will be `punctuation`,
/// `keyName` and `KeyValue` for a Json format.
public protocol Category {

    var cssClass: CSSClass { get }
    var terminalModifier: TerminalModifier { get }

    #if !os(Linux)
    var color: Color { get }
    #endif

    init(from match: String)
}
