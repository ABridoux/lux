public struct TerminalColor {

    /// Escape code to reset the color in the terminal. Used to stop the colorisation.
    public static var reset: String { "\u{001B}[0;0m" }
}
