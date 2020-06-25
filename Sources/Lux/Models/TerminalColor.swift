struct TerminalModifier {

    var raw: String

    init(raw: String) {
        self.raw = raw
    }

    init(colorCode: Int) {
        self.raw = "\u{001B}[38;5;\(colorCode)m"
    }
}

extension TerminalModifier {
    static var resetColors: TerminalModifier { TerminalModifier(raw: "\u{001B}[0;0m") }
}
