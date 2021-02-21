import Foundation
import SwiftSoup

/// Target `<pre><code>`tags in a HTML file and use an injectors set to modify the code blocks.
public enum FileInjectionService {

    // MARK: - Functions

    public static func inject(in text: String, using injectors: [TextInjector]) throws -> String {

        let languageIdentifiers = Set(injectors.flatMap { $0.languageIdentifiers })

        let document = try SwiftSoup.parse(text)
        let codes = try document.select("pre code")
        try codes.forEach { (codeBlock) in
            let classAttr = try codeBlock.attr("class")

            guard
                let identifier = languageIdentifiers.first(where: { $0 == classAttr }),
                let injector = getInjectorFor(languageIdentifier: identifier, from: injectors) // get the concerned injector
            else { return }

            let modifiedCode: String
            switch injector.dataFormat {
            case .plist, .xml, .xmlEnhanced:
                modifiedCode = try injector.inject(in: codeBlock.outerHtml())
            case .json, .zsh, .swift:
                modifiedCode = try injector.inject(in: codeBlock.text())
            }
            try codeBlock.html(modifiedCode)
        }

        return try document.html()
    }

    /// - Parameters:
    ///   - languageIdentifier: The language identifier corresponding to one potential Injector
    ///   - injectors: List of potential injectors
    /// - Returns: The Injector responsibme for the given language identifier
    static func getInjectorFor(languageIdentifier: String, from injectors: [TextInjector]) -> TextInjector? {
        for injector in injectors {
            if injector.languageIdentifiers.contains(languageIdentifier) {
                return injector
            }
        }
        return nil
    }
}
