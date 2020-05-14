import Foundation

/// An object which can be initialised as empty, and can add other same objects to itself
public protocol Appendable {
    static var empty: Self { get }

    init(_ string: String)

    mutating func append(_ other: Self)
}

extension String: Appendable {
    public static var empty: String { "" }
}
