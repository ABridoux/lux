#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

extension TerminalModifier {
    struct XcodeLight {
        let plainText = TerminalModifier.resetColors
        let keyword = TerminalModifier(colorCode: 90)
        let string = TerminalModifier(colorCode: 160)
        let type = TerminalModifier(colorCode: 23)
        let call = TerminalModifier(colorCode: 24)
        let number = TerminalModifier(colorCode: 21)
        let comment = TerminalModifier(colorCode: 245)
        let property = TerminalModifier(colorCode: 24)
        let dotAccess = TerminalModifier(colorCode: 24)
        let preprocessing = TerminalModifier(colorCode: 95)
        let custom = TerminalModifier.resetColors
    }

    static var xcodeLight: XcodeLight { XcodeLight() }
}

extension Color {
    struct XcodeLight {
        let plainText = Color.black
        let comment = Color(r: 93, g: 108, b: 121)
        let preprocessing = Color(r: 100, g: 56, b: 32)
        let keyword = Color(r: 155, g: 35, b: 147)
        let string = Color(r: 196, g: 26, b: 22)
        let url = Color(r: 14, g: 14, b: 255)
        let type = Color(r: 28, g: 70, b: 74)
        let call = Color(r: 50, g: 109, b: 116)
        let number = Color(r: 28, g: 0, b: 7)
        let property = Color(r: 50, g: 109, b: 116)
        let dotAccess = Color(r: 50, g: 109, b: 116)
        let custom = Color.black
        let background = Color.white
    }

    static var xcodeLight: XcodeLight { XcodeLight() }
}
