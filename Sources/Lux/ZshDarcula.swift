#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public extension ZshDelegate {
    static var darcula: ZshDelegate { ZshDarcularDelegate() }
}

open class ZshDarcularDelegate: ZshDelegate {

    override open func color(for category: ZshCategory) -> Color {
        #if !os(macOS)
        switch category {
        case .program: return UIColor(hex: "#50FA7B")!
        case .optionNameOrFlag: return UIColor(hex: "#BD93F9")!
        case .commandOrOptionValue: return UIColor(hex: "#FFB86C")!
        case .punctuation: return UIColor(hex: "#F8F8F2")!
        case .variable: return UIColor(hex: "#F8F8F2")!
        case .string: return UIColor(hex: "#F1FA8C")!
        case .keyword: return UIColor(hex: "#FF79C6")!
        case .comment: return UIColor(hex: "#6272A4")!
        }
        #else

        switch category {
        case .program: return NSColor.labelColor
        case .optionNameOrFlag: return NSColor(hex: "#F2836B")!
        case .commandOrOptionValue: return NSColor(hex: "#F2594B")!
        case .punctuation: return NSColor.systemGray
        case .variable: return NSColor(hex: "#63A69F")!
        case .string: return NSColor(hex: "#869CA6")!
        case .keyword: return NSColor(hex: "#A67574")!
        case .comment: return NSColor.lightGray
        }
        #endif
    }
}
