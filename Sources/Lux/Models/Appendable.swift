import Foundation

/// An object which can be initialised as empty, and can add other same objects to itself
public protocol Appendable {

    init(_ string: String)

    static var empty: Self { get }

    mutating func append(_ other: Self)

    init(attributedString: NSAttributedString)
    init(attributedString: AttributedString)
}

extension String: Appendable {
    public static var empty: String { "" }

    public init(attributedString: NSAttributedString) {
        self = attributedString.string
        assertionFailure("Initialisation of a string from a 'NSAttributedString' is implemented to be compliant with the protocol 'Appendable'. It should not be used")
    }

    public init(attributedString: AttributedString) {
        self = attributedString.nsAttributedString.string
        assertionFailure("Initialisation of a string from a 'NSAttributedString' is implemented to be compliant with the protocol 'Appendable'. It should not be used")
    }
}

extension Appendable {
    static func + (lhs: Self, rhs: Self) -> Self {
        var copy = lhs
        copy.append(rhs)
        return copy
    }

    static func += (lhs: inout Self, rhs: Self) {
        lhs.append(rhs)
    }
}
