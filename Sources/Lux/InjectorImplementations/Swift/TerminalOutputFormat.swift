import Splash

public struct TerminalOutputFormat: OutputFormat {
    public var classPrefix: String
    public var delegate: InjectorDelegate<SwiftCategory>?

    public init(classPrefix: String = "", delegate: InjectorDelegate<SwiftCategory>? = nil) {
        self.classPrefix = classPrefix
    }

    public func makeBuilder() -> Builder {
        return Builder(classPrefix: classPrefix, delegate: delegate)
    }
}

extension TerminalOutputFormat {

    // we have to customize the builder to inject specific css classes
    public struct Builder: OutputBuilder {
        private let classPrefix: String
        private var output = ""
        private var pendingToken: (string: String, type: TokenType)?
        private var pendingWhitespace: String?
        var lastColor: String?

        var injectorDelegate: InjectorDelegate<SwiftCategory>

        // MARK: - Initialisation

        fileprivate init(classPrefix: String, delegate: InjectorDelegate<SwiftCategory>?) {
            self.classPrefix = classPrefix
            self.injectorDelegate = delegate ?? SwiftDelegate()
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
            output.append(TerminalModifier.resetColors.raw)
            output.append(text)
        }

        public mutating func addWhitespace(_ whitespace: String) {
            if pendingToken != nil {
                pendingWhitespace = (pendingWhitespace ?? "") + whitespace
            } else {
                output.append(whitespace)
            }
        }

        public mutating func build() -> String {
            appendPending()
            return output
        }

        private mutating func appendPending() {
            if let pending = pendingToken {
                let colorMark = injectorDelegate.injection(for: pending.type, type: .plain)
                output.append("\(colorMark)\(pending.string)\(lastColor ?? "")")
                lastColor = colorMark
                pendingToken = nil
            }

            if let whitespace = pendingWhitespace {
                output.append(whitespace)
                pendingWhitespace = nil
            }
        }
    }
}
