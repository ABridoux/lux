import Foundation

public protocol Appendable {
    static var empty: Self { get }

    init(_ string: String)

    mutating func append(_ other: Self)
}

extension String: Appendable {
    public static var empty: String { "" }
}

public struct AttributedString: Appendable {

    public static var empty: AttributedString { AttributedString() }

    var fullRange: NSRange { NSRange(location: 0, length: attrString.length) }

    public var attrString: NSMutableAttributedString

    public var textColor: Color {
        get {
            attrString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? Color ?? Colors.defaultColor
        }

        set {
            attrString.setAttributes([.foregroundColor: newValue], range: fullRange)
        }
    }

    public init(_ string: String) {
        attrString = NSMutableAttributedString(string: string)
    }

    public init(_ substring: Substring) {
        attrString = NSMutableAttributedString(string: String(substring))
    }

    public init() {
        attrString = NSMutableAttributedString(string: "")
    }

    public func append(_ other: AttributedString) {
        attrString.append(other.attrString as NSAttributedString)
    }
}
