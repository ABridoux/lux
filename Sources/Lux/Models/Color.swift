#if !os(macOS)
import UIKit
#else
import AppKit
#endif

/// A UIColor or NSColor
public protocol Color {}

#if !os(macOS)
extension UIColor: Color {}
#else
extension NSColor: Color {}
#endif
