import Lux
import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json

    var injectorPlain: Injector {
        switch self {
        case .xml: return XmlInjector(type: .plain)
        case .plist: return PlistInjector(type: .plain)
        case .json: return JSONInjector(type: .plain)
        }
    }
}
