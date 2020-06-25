import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json, zsh, swift

    func injector(type: TextType) -> Injector {
        switch self {
        case .xml: return XMLEnhancedInjector(type: type)
        case .plist: return PlistInjector(type: type)
        case .json: return JSONInjector(type: type)
        case .zsh: return ZshInjector(type: type)
        case .swift: return SwiftInjector(type: type)
        }
    }
}
