import Foundation

/// Target `<pre><code>`tags in a HTML file and use a format injector to modify the found code blocks
public struct FileInjectionService {

    // MARK: - Constants

    static let precodePrefixPattern = #"<pre([^<^>]*("[^"]+"|'[^']+')[^<^>]*|[^<^>]*)><code([^<^>]*("[^"]+"|'[^']+')[^<^>]*|[^<^>]*)>"#
    static let precodePrefixRegex = try! NSRegularExpression(pattern: precodePrefixPattern)
    static let precodeSuffixPattern = #"</code>\n?</pre>"#
    static let precodeSuffixRegex = try! NSRegularExpression(pattern: precodeSuffixPattern)

    // MARK: - Functions

    static func buildRegex(withLanguageIdentifiers identifiers: Set<String>) throws -> NSRegularExpression {
        let identifiers = "(\(identifiers.joined(separator: "|")))"
        let pattern = #"(<pre[^<^>]*><code[^<^>]*class="\#(identifiers)"[^<^>]*>"# +
        #"|<pre[^<^>]*class="\#(identifiers)"[^<^>]*><code[^<^>]*>)"# +
        #"[^<^>]*<\/code><\/pre>"#

        return try NSRegularExpression(pattern: pattern)
    }

    public static func inject(in text: String, using injector: Injector) throws -> String {

        // build the regex
        let preCodeRegex = try buildRegex(withLanguageIdentifiers: injector.languageIdentifiers)
        let nsText = text as NSString
        let textRange = text.nsRange
        let matches = preCodeRegex.matches(in: text, options: [], range: textRange)
        var modifiedText = ""

        guard let firstMatch = matches.first else { return text }

        // take the gap between the text beginning and the first match
        let firstGap = NSRange(location: 0, length: firstMatch.range.lowerBound)

        if firstGap.length > 0 {
            let gapString = nsText[firstGap]
            modifiedText.append(gapString)
        }

        for index in 0..<matches.count - 1 {
            let currentMatch = matches[index]
            let nextMatch = matches[index + 1]

            // get the modfified current code block
            let currentMatchString = nsText.substring(with: currentMatch.range)

            handle(currentMatchString, with: injector, appendingTo: &modifiedText)

            // get the string between the current code block and the next one
            let gapBetweenMatches = NSRange(location: currentMatch.range.upperBound, length: nextMatch.range.lowerBound - currentMatch.range.upperBound)

            if gapBetweenMatches.length > 0 {
                let gapBetweenMatchesString = nsText[gapBetweenMatches]
                modifiedText.append(gapBetweenMatchesString)
            }
        }

        // take care of the last match
        guard let lastMatch = matches.last else { return text }
        let lastMatchString = nsText.substring(with: lastMatch.range)
        handle(lastMatchString, with: injector, appendingTo: &modifiedText)

        // take the gap between the last match and the end of the text
        let lastGap = NSRange(location: lastMatch.range.upperBound, length: textRange.upperBound - lastMatch.range.upperBound)

        if lastGap.length > 0 {
            let gapString = nsText[lastGap]
            modifiedText.append(gapString)
        }

        return modifiedText
    }

    /// Modify the `finalString` parameter  by extracting the `<pre><code>` tags in the match if present, and inject the color markers in the match
    /// - Parameters:
    ///   - match: The string in which to inject color markers
    ///   - injector: The injector to inject color markers
    ///   - finalString: The string holding the current modified text that will be returned
    static func handle(_ match: String, with injector: Injector, appendingTo finalString: inout String) {
        if let (prefix, code, suffix) = splitPreCodeTags(in: match) { // we have pre code tags
            // append the pre code prefix
            finalString.append(String(prefix))
            //append the modified code
            let modifiedCode = injector.inject(in: String(code))
            finalString.append(modifiedCode)
            // append the pre code suffix
            finalString.append(String(suffix))
        } else {
            let modifiedMatch = injector.inject(in: match)
            finalString.append(modifiedMatch)
        }
    }

    /// Remove the `<pre><code>` tags from the given code block
    /// - Parameter codeBlock: The overalll code block to modify
    /// - Returns: The prefix `<pre><code>`, the code block, and the sufix `</code></pre>`
    public static func splitPreCodeTags(in codeBlock: String) -> (prefix: String, code: String, suffix: String)? {
        let nsCodeblock = codeBlock as NSString
        let range = NSRange(location: 0, length: nsCodeblock.length)
        guard
            let prefix = precodePrefixRegex.firstMatch(in: codeBlock, options: [], range: range)?.range,
            let suffix = precodeSuffixRegex.firstMatch(in: codeBlock, options: [], range: range)?.range
        else {
            return nil
        }

        let prefixString = nsCodeblock[prefix]
        let suffixString = nsCodeblock[suffix]

        let codeLength = suffix.lowerBound - prefix.upperBound
        guard codeLength > 0 else {
            return nil
        }

        let codeRange = NSRange(location: prefix.upperBound, length: codeLength)
        let codeString = nsCodeblock[codeRange]

        return (prefixString, codeString, suffixString)
    }
}

extension FileInjectionService {

    public static func injectPlist(in text: String) throws -> String { try inject(in: text, using: PlistInjector(type: .html)) }
    public static func injectXml(in text: String) throws -> String { try inject(in: text, using: XMLInjector(type: .html)) }
    public static func injectJson(in text: String) throws -> String { try inject(in: text, using: JSONInjector(type: .html)) }
}
