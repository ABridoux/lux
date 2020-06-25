import Splash

public struct HTMLCustomCSSOutputFormat: OutputFormat {
    public var classPrefix: String
    public var delegate: InjectorDelegate<SwiftCategory>?

    public init(classPrefix: String = "", delegate: InjectorDelegate<SwiftCategory>? = nil) {
        self.classPrefix = classPrefix
    }

    public func makeBuilder() -> CustomCSSBuilder {
        return CustomCSSBuilder(classPrefix: classPrefix, delegate: delegate)
    }
}

extension HTMLCustomCSSOutputFormat {

    // we have to customize the builder to inject specific css classes
    public struct CustomCSSBuilder: OutputBuilder {
        private let classPrefix: String
        private var html = ""
        private var pendingToken: (string: String, type: TokenType)?
        private var pendingWhitespace: String?

        var injectorDelegate: InjectorDelegate<SwiftCategory>?

        // MARK: - Initialisation

        fileprivate init(classPrefix: String, delegate: InjectorDelegate<SwiftCategory>?) {
            self.classPrefix = classPrefix
            self.injectorDelegate = delegate
        }

        public mutating func addToken(_ token: String, ofType type: TokenType) {
            if var pending = pendingToken {
                guard pending.type != type else {
                    pendingWhitespace.map { pending.string += $0 }
                    pendingWhitespace = nil
                    pending.string += token
                    pendingToken = pending
                    return
                }
            }

            appendPending()
            pendingToken = (token, type)
        }

        public mutating func addPlainText(_ text: String) {
            appendPending()
            html.append(text)
        }

        public mutating func addWhitespace(_ whitespace: String) {
            if pendingToken != nil {
                pendingWhitespace = (pendingWhitespace ?? "") + whitespace
            } else {
                html.append(whitespace)
            }
        }

        public mutating func build() -> String {
            appendPending()
            return html
        }

        private mutating func appendPending() {
            if let pending = pendingToken {
                let customCssClass = injectorDelegate?.injection(for: pending.type, type: .html)
                html.append("""
                <span class="\(classPrefix)\(customCssClass ?? pending.type.string)">\(pending.string)</span>
                """)

                pendingToken = nil
            }

            if let whitespace = pendingWhitespace {
                html.append(whitespace)
                pendingWhitespace = nil
            }
        }
    }
}
