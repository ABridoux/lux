import Foundation

extension NSRegularExpression {

    /// Returns the range of the first string inside double quotes in the given string
    static func rangeOfQuotedString(in string: String) -> NSRange? {
        let regex = try! NSRegularExpression(pattern: #"(?<=")[^"]+(?=")"#, options: [])

        let nsString = string as NSString
        let range = NSRange(location: 0, length: nsString.length)
        return regex.firstMatch(in: string, options: [], range: range)?.range
    }

    static func trimmedWhiteSpacesAndNewLinesRange(in string: String) -> NSRange? {
        let regex = try! NSRegularExpression(pattern: #"[^\s*].*[^\s*]"#)

        let nsString = string as NSString
        let range = NSRange(location: 0, length: nsString.length)
        return regex.firstMatch(in: string, options: [], range: range)?.range
    }
}
