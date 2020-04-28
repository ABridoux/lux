import ArgumentParser

enum Format: String, ExpressibleByArgument {
    case plist, xml, json
}
