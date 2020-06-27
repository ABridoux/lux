#if !os(macOS)
import UIKit
#else
import AppKit
#endif

/*
 https://spec.draculatheme.com
 */

extension TerminalModifier {
    struct Dracula {
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

extension Color {
    public struct Dracula {
        let function: Color = Color(hex: "#50FA7B")!
        let functionsDecorator = Color(hex: "#50FA7B")!
        let functionParameter = Color(hex: "#FFB86C")!
        let punctuation = Color(hex: "#F8F8F2")!
        let variable = Color(hex: "#F8F8F2")!
        let string = Color(hex: "#F1FA8C")!
        let keyword = Color(hex: "#FF79C6")!
        let comment = Color(hex: "#6272A4")!
        let fileHeader = Color(hex: "#8BE9FD")!
        let classOrType = Color(hex: "#8BE9FD")!
        let constant = Color(hex: "#BD93F9")!
        let background = Color(hex: "#282A36")!
    }

    public static var dracula: Dracula { Dracula() }
}
