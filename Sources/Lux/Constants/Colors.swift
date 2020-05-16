#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public struct Colors {

    /// Escape code to reset the color in the terminal. Used to stop the colorisation.
    public static var terminalReset: String { "\u{001B}[0;0m" }

    static var defaultColor: Color {
        #if !os(macOS)
        return UIColor.black
        #else
        return NSColor.black
        #endif
    }
}
