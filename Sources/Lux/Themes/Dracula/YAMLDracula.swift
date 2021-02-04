//
// Scout
// Copyright (c) Alexis Bridoux 2020
// MIT license, see LICENSE file for details

#if canImport(iOS)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension YAMLDelegate {
    static var dracula: YAMLDelegate { YAMLDraculaDelegate() }
}

final class YAMLDraculaDelegate: YAMLDelegate, DraculaThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: YAMLCategory) -> Color {
        switch category {
        case .keyName: return Color.dracula.function
        case .keyValue: return Color.dracula.functionParameter
        case .punctuation: return Color.dracula.punctuation
        }
    }
    #endif

    override func terminalModifier(for category: YAMLCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.dracula.function
        case .keyValue: return TerminalModifier.dracula.functionParameter
        case .punctuation: return TerminalModifier.dracula.punctuation
        }
    }
}
