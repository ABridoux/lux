#if !os(macOS)
import UIKit
#else
import AppKit
#endif

/// A UIColor or NSColor
public protocol Color {}

#if !os(macOS)
extension UIColor: Color {}

extension UIColor {
    /**
        Init a `UIColor` with an hexadecimal code
        - parameter hex: Represented as #ffe700ff
        - note: [Source](https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor)
        */
    public convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat

        guard hex.hasPrefix("#") else {
            return nil
        }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        var hexColor = String(hex[start...])
        if hexColor.count < 8 {
            // try to add 0s at the end of the hexa string to count to 8
            hexColor += String(repeating: "F", count: 8 - hexColor.count)
        }
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }

        red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        alpha = CGFloat(hexNumber & 0x000000ff) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#else
extension NSColor: Color {}

extension NSColor {
    /**
    Init a `NSColor` with an hexadecimal code
    - parameter hex: Represented as #ffe700ff
    - note: [Source](https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor)
    */
    public convenience init?(hex: String) {
        let red, green, blue, alpha: CGFloat

        guard hex.hasPrefix("#") else {
            return nil
        }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        var hexColor = String(hex[start...])
        if hexColor.count < 8 {
            // try to add 0s at the end of the hexa string to count to 8
            hexColor += String(repeating: "F", count: 8 - hexColor.count)
        }
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) else {
            return nil
        }

        red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        alpha = CGFloat(hexNumber & 0x000000ff) / 255

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

#endif
