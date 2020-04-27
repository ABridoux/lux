extension RegexPattern {
    static let json = RegexPattern(#"(\{|\}|\(|\)|\[|\]|,|"[^"]*":|"[^"]*")"#, type: .plain)
}
