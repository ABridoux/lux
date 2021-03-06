import Foundation

/// A wrapper around `NSMutableString`
/// - note: `init(attributedString:)` [seems to be broken](https://forums.macrumors.com/threads/nsconcreteattributedstring-mutablestring-crash.878218/)
/// so we cannnot use it with Splash
public struct AttributedString: Appendable {

    public static var empty: AttributedString { AttributedString() }

    var fullRange: NSRange { NSRange(location: 0, length: nsAttributedString.length) }

    public var nsAttributedString: NSMutableAttributedString

    #if !os(Linux)
    public var textColor: Color {
        get {
            nsAttributedString.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? Color ?? .plainText
        }

        set {
            nsAttributedString.setAttributes([.foregroundColor: newValue], range: fullRange)
        }
    }
    #endif

    public init(_ string: String) {
        nsAttributedString = NSMutableAttributedString(string: string)
    }

    #if !os(Linux)
    public init(_ string: String, color: Color) {
        nsAttributedString = NSMutableAttributedString(string: string)
        textColor = color
    }
    #endif

    public init(_ substring: Substring) {
        nsAttributedString = NSMutableAttributedString(string: String(substring))
    }

    public init() {
        nsAttributedString = NSMutableAttributedString(string: "")
    }

    public func append(_ other: AttributedString) {
        nsAttributedString.append(other.nsAttributedString as NSAttributedString)
    }

    public init(attributedString: NSAttributedString) {
        self.nsAttributedString = NSMutableAttributedString(attributedString: attributedString)
    }

    public init(attributedString: AttributedString) {
        self = attributedString
    }

    #if !os(Linux)
    mutating public func append(_ string: String, with color: Color) {
        var attrString = AttributedString(string)
        attrString.textColor = color
        append(attrString)
    }
    #endif
}
