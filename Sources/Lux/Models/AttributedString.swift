import Foundation

/// A wrapper around `NSMutableString`
public struct AttributedString: Appendable {

    public static var empty: AttributedString { AttributedString() }

    var fullRange: NSRange { NSRange(location: 0, length: nsAttributedString.length) }

    public var nsAttributedString: NSMutableAttributedString

    public var textColor: Color {
        get {
            nsAttributedString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? Color ?? Colors.defaultColor
        }

        set {
            nsAttributedString.setAttributes([.foregroundColor: newValue], range: fullRange)
        }
    }

    public init(_ string: String) {
        nsAttributedString = NSMutableAttributedString(string: string)
    }

    public init(_ substring: Substring) {
        nsAttributedString = NSMutableAttributedString(string: String(substring))
    }

    public init() {
        nsAttributedString = NSMutableAttributedString(string: "")
    }

    public func append(_ other: AttributedString) {
        nsAttributedString.append(other.nsAttributedString as NSAttributedString)
    }
}
