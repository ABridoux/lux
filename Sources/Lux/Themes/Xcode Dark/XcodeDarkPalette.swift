#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension TerminalModifier {
    struct XcodeDark {
        let plainText = TerminalModifier.resetColors
        let keyword = TerminalModifier(colorCode: 168)
        let string = TerminalModifier(colorCode: 1)
        let type = TerminalModifier(colorCode: 37)
        let call = TerminalModifier(colorCode: 113)
        let number = TerminalModifier(colorCode: 98)
        let comment = TerminalModifier(colorCode: 249)
        let property = TerminalModifier(colorCode: 113)
        let dotAccess = TerminalModifier(colorCode: 113)
        let preprocessing = TerminalModifier(colorCode: 208)
        let custom = TerminalModifier.resetColors
    }

    static var xcodeDark: XcodeDark { XcodeDark() }
}

#if !os(Linux)
extension Color {
    struct XcodeDark {
        let plainText = Color.white
        let comment = Color(r: 108, g: 121, b: 134)
        let preprocessing = Color(r: 253, g: 143, b: 63)
        let keyword = Color(r: 252, g: 95, b: 163)
        let string = Color(r: 252, g: 108, b: 93)
        let url = Color(r: 83, g: 165, b: 251)
        let type = Color(r: 145, g: 212, b: 98)
        let call = Color(r: 145, g: 212, b: 98)
        let number = Color(r: 150, g: 134, b: 245)
        let property = Color(r: 145, g: 212, b: 98)
        let dotAccess = Color(r: 145, g: 212, b: 98)
        let custom = Color.white
        let background = Color(r: 31, g: 31, b: 36)
    }

    static var xcodeDark: XcodeDark { XcodeDark() }
}
#endif
