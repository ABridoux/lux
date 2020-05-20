import Foundation

extension String {

    /// The full NS range of the string
    var nsRange: NSRange { NSRange(location: 0, length: utf16.count) }

    subscript(_ range: NSRange) -> Substring {
        let sliceStartIndex = index(startIndex, offsetBy: range.location)
        let sliceEndIndex = index(startIndex, offsetBy: range.upperBound - 1)
        return self[sliceStartIndex...sliceEndIndex]
    }
}

extension Substring {

    subscript(_ range: NSRange) -> Substring {
        let sliceStartIndex = index(startIndex, offsetBy: range.location)
        let sliceEndIndex = index(startIndex, offsetBy: range.upperBound - 1)
        return self[sliceStartIndex...sliceEndIndex]
    }
}

extension NSString {

    subscript(_ range: NSRange) -> String { substring(with: range) }
}
