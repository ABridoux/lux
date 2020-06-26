import Foundation

internal extension StringProtocol {
    // from https://github.com/JohnSundell/Splash/blob/master/Sources/Splash/Extensions/Strings/String%2BHTMLEntities.swift
    func escapingHTMLEntities() -> String {
        return String(flatMap { character -> String in
            switch character {
            case "&":
                return "&amp;"
            case "<":
                return "&lt;"
            case ">":
                return "&gt;"
            default:
                return String(character)
            }
        })
    }
}
