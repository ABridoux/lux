import Foundation

/// Target `<pre><code>`tags in a HTML file and use a format injector to modify the found code blocks
public struct FileInjectionService {

    // MARK: - Constants

    static let precodePrefixPattern = #"<pre([^<^>]*("[^"]+"|'[^']+')[^<^>]*|[^<^>]*)>[\s\n]*<code([^<^>]*("[^"]+"|'[^']+')[^<^>]*|[^<^>]*)>"#
    static let precodePrefixRegex = try! NSRegularExpression(pattern: precodePrefixPattern)
    static let precodeSuffixPattern = #"</code>[\s\n]*</pre>"#
    static let precodeSuffixRegex = try! NSRegularExpression(pattern: precodeSuffixPattern)

    // MARK: - Functions

    static func buildRegex(withLanguageIdentifiers identifiers: Set<String>) throws -> NSRegularExpression {
        let identifiers = "(\(identifiers.joined(separator: "|")))"
        let pattern = #"(<pre[^<^>]*>[\s\n]*<code[^<^>]*class="[^"]*\#(identifiers)[^"]*"[^<^>]*>"# +
        #"|<pre[^<^>]*class="[^"]*\#(identifiers)[^"]*"[^<^>]*>[\s\n]*<code[^<^>]*>)"# +
        #"[^<^>]*<\/code>[\s\n]*<\/pre>"#

        return try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
    }

    public static func inject(in text: String, using injectors: [Injector]) throws -> String {

        // build the regex
        let languageIdentifiers = Set(injectors.flatMap { $0.languageIdentifiers })
        let preCodeRegex = try buildRegex(withLanguageIdentifiers: languageIdentifiers)
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

            handle(currentMatchString, with: injectors, appendingTo: &modifiedText)

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
        handle(lastMatchString, with: injectors, appendingTo: &modifiedText)

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
    static func handle(_ match: String, with injectors: [Injector], appendingTo finalString: inout String) {
        let languageIdentifiers = Set(injectors.flatMap { $0.languageIdentifiers })

        guard
            let (prefix, code, suffix) = splitPreCodeTags(in: match), // get the pre code tags
            let languageIdentifier = extractLanguageIdentifier(in: languageIdentifiers, from: prefix), // get the language identifier
            let injector = getInjectorFor(languageIdentifier: languageIdentifier, from: injectors) // get the concerned injector
        else {
            finalString.append(match)
            return
        }

        // append the pre code prefix
        finalString.append(prefix)
        //append the modified code
        let modifiedCode = injector.inject(in: code)
        finalString.append(modifiedCode)
        // append the pre code suffix
        finalString.append(suffix)
    }

    /// Extract the language identifier from the given list in the given string
    /// - Parameters:
    ///   - identifiers: A list of identifiers to match
    ///   - string: A `<pre><code>` tags set containing a `class="[LanguageIdentifier]"`
    /// - Returns: The language identifier if found
    static func extractLanguageIdentifier(in identifiers: Set<String>, from string: String) -> String? {
        let pattern = identifiers.joined(separator: "|")
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])

        guard let match = regex.firstMatch(in: string, options: [], range: string.nsRange) else {
            return nil
        }

        return String(string[match.range])
    }

    /// - Parameters:
    ///   - languageIdentifier: The language identifier corresponding to one potential Injector
    ///   - injectors: List of potential injectors
    /// - Returns: The Injector responsibme for the given language identifier
    static func getInjectorFor(languageIdentifier: String, from injectors: [Injector]) -> Injector? {
        for injector in injectors {
            if injector.languageIdentifiers.contains(languageIdentifier) {
                return injector
            }
        }
        return nil
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

    public static func injectPlist(in text: String) throws -> String { try inject(in: text, using: [PlistInjector(type: .html)]) }
    public static func injectXml(in text: String) throws -> String { try inject(in: text, using: [XMLEnhancedInjector(type: .html)]) }
    public static func injectJson(in text: String) throws -> String { try inject(in: text, using: [JSONInjector(type: .html)]) }
}
