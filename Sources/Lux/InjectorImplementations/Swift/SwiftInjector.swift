import Foundation
import Splash

public final class SwiftInjector: BaseInjector<SwiftCategory> {

    override public init(type: TextType, delegate: BaseInjector<SwiftCategory>.Delegate = SwiftDelegate(), languageName: String = "swift") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    override public func inject(in text: String) -> String {
        switch type {

        case .html:
            let format = HTMLCustomCSSOutputFormat(classPrefix: "", delegate: delegate)
            let highlighter = SyntaxHighlighter(format: format)
            return highlighter.highlight(text)

        case .plain:
            let format = TerminalOutputFormat(classPrefix: "", delegate: delegate)
            let highlighter = SyntaxHighlighter(format: format)
            return highlighter.highlight(text)
        }
    }

    override public func injectAttributed(in text: String) -> NSMutableAttributedString {
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: delegate.theme))
        return NSMutableAttributedString(attributedString: highlighter.highlight(text))
    }
}
