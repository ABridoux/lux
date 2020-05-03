public protocol Injector {

    var languageIdentifiers: Set<String> { get set }

    func inject(in text: String) -> String
}
