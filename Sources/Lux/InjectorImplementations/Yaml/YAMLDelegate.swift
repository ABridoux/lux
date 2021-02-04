//
// Scout
// Copyright (c) Alexis Bridoux 2020
// MIT license, see LICENSE file for details

public typealias YAMLDelegate = InjectorDelegate<YAMLCategory>

extension YAMLDelegate {

    public static func theme(_ theme: ColorTheme) -> YAMLDelegate {
        switch theme {
        case .dracula: return .dracula
        case .xcodeLight: return .xcodeLight
        case .xcodeDark: return .xcodeDark
        }
    }
}
