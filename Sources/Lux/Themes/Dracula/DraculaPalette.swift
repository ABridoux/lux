#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/*
 https://spec.draculatheme.com
 */

extension TerminalModifier {
    struct Dracula {
        let plainText = TerminalModifier.resetColors
        let function = TerminalModifier(colorCode: 155)
        let functionDecorator = TerminalModifier(colorCode: 155)
        let functionParameter = TerminalModifier(colorCode: 166)
        let punctuation = TerminalModifier(colorCode: 248)
        let variable = TerminalModifier(colorCode: 255)
        let string = TerminalModifier(colorCode: 229)
        let keyword = TerminalModifier(colorCode: 206)
        let comment = TerminalModifier(colorCode: 24)
        let fileHeader = TerminalModifier(colorCode: 81)
        let constant = TerminalModifier(colorCode: 134)
        let classOrType = TerminalModifier(colorCode: 81)
    }

    static var dracula: Dracula { Dracula() }
}

#if !os(Linux)
extension Color {
    struct Dracula {
        let plainText = Color.white
        let function = Color(r: 80, g: 250, b: 123)
        let functionsDecorator = Color(r: 80, g: 250, b: 123)
        let functionParameter = Color(r: 255, g: 184, b: 108)
        let punctuation = Color(r: 248, g: 248, b: 242)
        let variable = Color(r: 248, g: 248, b: 242)
        let string = Color(r: 241, g: 250, b: 140)
        let keyword = Color(r: 255, g: 121, b: 198)
        let comment = Color(r: 98, g: 114, b: 164)
        let fileHeader = Color(r: 139, g: 233, b: 253)
        let classOrType = Color(r: 139, g: 233, b: 253)
        let constant = Color(r: 189, g: 147, b: 249)
        let background = Color(r: 40, g: 42, b: 54)
    }

    static var dracula: Dracula { Dracula() }
}
#endif
