#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// Used by an Injector to know which color to use for a given categorised match, and how to inject this color.
open class InjectorDelegate<Cat: Category> {

    // MARK: - Initialisation

    required public init() {}

    // MARK: - Functions

    #if !os(Linux)
    //// Called by the injector to get the color to use for the given category when dealing with attributed output
    open func color(for category: Cat) -> Color { category.color }

    /// The background color to use along with the color theme for an application
    open var backgroundColor: Color { (self as? ThemeInjectorDelegate)?.themeBackgroundColor ?? .white }
    #endif

    /// Called by the injector to get the CSS class to use for the given category when dealing with HTML output
    open func cssClass(for category: Cat) -> CSSClass { category.cssClass }

    /// Called by the injector to get the terminal modifier to use for the given category when dealing terminal output
    open func terminalModifier(for category: Cat) -> TerminalModifier { category.terminalModifier }

    /// Called by the injector to know what injection to use for a given category
    func injection<Injection: InjectionType, Output: Appendable>(for category: Cat, in injectorType: InjectorType<Output, Injection>) -> Injection {
        #if !os(Linux)
        if let color = color(for: category) as? Injection {
            return color
        }
        #endif

        if let cssClass = cssClass(for: category) as? Injection {
            return cssClass
        } else if let terminalModifier = terminalModifier(for: category) as? Injection {
            return terminalModifier
        } else {
            assertionFailure("\(Injection.self) not handled")
            return Injection.none()
        }
    }

    /// Called by the injector to know how to inject an injection in a string of a given category. Override this funtion to change the default behavior.
    /// - Parameters:
    ///   - category: Category of the match found
    ///   - injectorType: Let you know the injector type used
    ///   - match: The match which as to be colorised.
    /// - Returns: The colorised match. The ouput type depends on the injector type used.
    open func inject<Output: Appendable, Injection: InjectionType>(_ category: Cat, in injectorType: InjectorType<Output, Injection>, _ match: String) -> Output {
        let injection = self.injection(for: category, in: injectorType)
        return injectorType.inject(injection, in: match)
    }
}
