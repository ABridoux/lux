import Foundation

public class InjectorType<Output: Appendable> {
    public static var terminal: Terminal { Terminal(textType: .plain) }
    public static var html: Html { Html(textType: .html) }
    public static var app: App { App(textType: .plain) }

    public var textType: TextType

    fileprivate init(textType: TextType) {
        self.textType = textType
    }
}

public final class Terminal: InjectorType<String> {}

public final class Html: InjectorType<String> {}

public final class App: InjectorType<AttributedString> {}
