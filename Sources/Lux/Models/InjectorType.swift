import Foundation

/// Phantom types of injector to use: **terminal**, **html** and **app**. Each one will have a specific output and injection types.
/// For example, the terminal injector will inject `TerminalModifier`s and output `Strings while
/// the app injector will inject `Color`s (`NSColor` or `UIColor`) and output `AttributedString`s (wrapper around `NSMutableString`)
public class InjectorType<Output: Appendable, Injection: InjectionType> {

    // MARK: - Constants

    /// Type of injector to use when outputting in a terminal. Will inject colors/weigth modifiers.
    public static var terminal: Terminal { Terminal(textType: .plain) }

    /// Type of injector to use when outputting in a HTML file. Will inject  `<span>` div with specific CSS classes
    public static var html: Html { Html(textType: .html) }

    /// Type of injector to use when outputting in an application with `NSAttributedString`. Will change the foreground color.
    public static var app: App { App(textType: .plain) }

    // MARK: - Properties

    public var textType: TextType

    // MARK: - Initialisation

    fileprivate init(textType: TextType) {
        self.textType = textType
    }

    // MARK: - Functions

    public func inject(_ injection: Injection, in text: String, previousInjection: Injection? = nil) -> Output {
        let textCount = text.nsRange.upperBound

        // try to get the range of the trimmed (white spaces and newlines) string
        guard let trimmedRange = NSRegularExpression.trimmedWhiteSpacesAndNewLinesRange(in: text),
            trimmedRange.lowerBound > 0 || trimmedRange.upperBound > 0 && trimmedRange.upperBound < textCount
        else { // no trimming was needed
            return untrimmedInject(injection, in: text, previousInjection: previousInjection)
        }

        // isolate left and right ranges to inject the string only in the trimmed string
        let text = text as NSString // conversion to keep special characters like emojis
        let trimmedText = text[trimmedRange]
        let injectedTrimmedOutput = untrimmedInject(injection, in: String(trimmedText), previousInjection: previousInjection)

        var injectedOutput = Output.empty

        if trimmedRange.lowerBound > 0 {
            let leftRange = NSRange(location: 0, length: trimmedRange.lowerBound
            )
            let leftText = text[leftRange]
            injectedOutput += Output(leftText)
        }

        injectedOutput += injectedTrimmedOutput

        if trimmedRange.upperBound <  textCount {
            let rightRange = NSRange(location: trimmedRange.upperBound, length: textCount - trimmedRange.upperBound)
            let rightText = text[rightRange]
            injectedOutput += Output(rightText)
        }

        return injectedOutput
    }

    fileprivate func untrimmedInject(_ injection: Injection, in text: String, previousInjection: Injection? = nil) -> Output {
        assertionFailure("Should not be called on Abstract type")
        return .empty
    }
}

// MARK: - Injectors definitions

/// Type of injector to use when outputting in a terminal
public final class Terminal: InjectorType<String, TerminalModifier> {

    override func untrimmedInject(_ injection: TerminalModifier, in text: String, previousInjection: TerminalModifier? = nil) -> String {
        injection.raw + text + (previousInjection ?? TerminalModifier.resetColors).raw
    }
}

/// Type of injector to use when outputting in a HTML file
public final class Html: InjectorType<String, CSSClass> {

    override public func inject(_ injection: CSSClass, in text: String, previousInjection: CSSClass? = nil) -> String {
        let text = text.escapingHTMLEntities()

        return super.inject(injection, in: text, previousInjection: previousInjection)
    }
    override func untrimmedInject(_ injection: String, in text: String, previousInjection: String? = nil) -> String {
        return #"<span class="\#(injection)">\#(text)</span>"#
    }
}

/// Type of injector to use when outputting in an application with NSAttributedString
public final class App: InjectorType<AttributedString, Color> {

    override func untrimmedInject(_ injection: Color, in text: String, previousInjection: Color? = nil) -> AttributedString {
        return AttributedString(text, color: injection)
    }
}
