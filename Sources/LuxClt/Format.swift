import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json

    func injector(type: TextType) -> Injector {
        switch self {
        case .xml: return XMLEnhancedInjector(type: type)
        case .plist: return PlistInjector(type: type)
        case .json: return JSONInjector(type: type)
        }
    }
}
