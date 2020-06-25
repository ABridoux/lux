/// Holds a raw string to modify the output in the terminal.
/// Specific initilisations are offered, like the one to specify a color with a 1-256 code as explained [here](https://misc.flogisoft.com/bash/tip_colors_and_formatting).
public struct TerminalModifier {

    // MARK: - Properties

    var raw: String

    // MARK: - Initialisation

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
