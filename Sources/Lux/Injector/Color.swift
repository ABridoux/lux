#if !os(macOS)
import UIKit
#else
import AppKit
#endif

public protocol Color {}

#if !os(macOS)
extension UIColor: Color {}
#else
extension NSColor: Color {}
#endif
