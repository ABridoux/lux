#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public struct Colors {

    /// Escape code to reset the color in the terminal. Used to stop the colorisation.
    public static var terminalReset: String { "\u{001B}[0;0m" }

    static var defaultColor: Color {
        #if os(iOS)
        return UIColor.black
        #elseif os(macOS)
        return NSColor.black
        #endif
    }
}
