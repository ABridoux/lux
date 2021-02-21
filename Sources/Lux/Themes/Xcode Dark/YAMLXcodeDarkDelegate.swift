//
// Scout
// Copyright (c) Alexis Bridoux 2020
// MIT license, see LICENSE file for details

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public extension YAMLDelegate {
    static var xcodeDark: YAMLDelegate { YAMLXcodeDarkDelegate() }
}

final class YAMLXcodeDarkDelegate: YAMLDelegate, XcodeDarkThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: YAMLCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeDark.property
        case .keyValue: return Color.xcodeDark.plainText
        case .punctuation: return Color.xcodeDark.comment
        }
    }
    #endif

    override func terminalModifier(for category: YAMLCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeDark.property
        case .keyValue: return TerminalModifier.xcodeDark.plainText
        case .punctuation: return TerminalModifier.xcodeDark.comment
        }
    }
}
