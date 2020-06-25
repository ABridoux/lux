import Foundation
import Splash

public final class SwiftInjector<Output: Appendable, InjType: InjectorType<Output>>: BaseInjector<SwiftCategory, Output, InjType> {

    override public init(type: InjType, delegate: Delegate = SwiftDelegate(), languageName: String = "swift") {
        super.init(type: type, delegate: delegate, languageName: languageName)
    }

    func injectString(in text: String) -> String {
        switch textType {

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

    func injectAttributed(in text: String) -> AttributedString {
        let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: delegate.theme))
        let nsAttrString = highlighter.highlight(text)
        return AttributedString(attributedString: nsAttrString)
    }

    override public func inject(in text: String) -> Output {
        switch type {
        case is Terminal: return Output(injectString(in: text))
        case is Html: return Output(injectString(in: text))
        case is App: return Output(attributedString: injectAttributed(in: text))
        default:
            assertionFailure("\(Output.self) not handled")
            return Output(text)
        }
    }
}
