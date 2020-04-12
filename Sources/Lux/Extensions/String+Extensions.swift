import Foundation

extension StringProtocol {

    /// The full NS range of the string
    var nsRange: NSRange { NSRange(location: 0, length: count) }
}

extension String {

    subscript(_ range: NSRange) -> Substring {
        let sliceStartIndex = index(startIndex, offsetBy: range.location)
        let sliceEndIndex = index(startIndex, offsetBy: range.upperBound - 1)
        return self[sliceStartIndex...sliceEndIndex]
    }
}
