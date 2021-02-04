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
    static var xcodeLight: YAMLDelegate { YAMLXcodeLightDelegate() }
}

final class YAMLXcodeLightDelegate: YAMLDelegate, XcodeLightThemeInjectorDelegate {

    #if !os(Linux)
    override func color(for category: YAMLCategory) -> Color {
        switch category {
        case .keyName: return Color.xcodeLight.property
        case .keyValue: return Color.xcodeLight.plainText
        case .punctuation: return Color.xcodeLight.comment
        }
    }
    #endif

    override func terminalModifier(for category: YAMLCategory) -> TerminalModifier {
        switch category {
        case .keyName: return TerminalModifier.xcodeLight.property
        case .keyValue: return TerminalModifier.xcodeLight.plainText
        case .punctuation: return TerminalModifier.xcodeLight.comment
        }
    }
}
