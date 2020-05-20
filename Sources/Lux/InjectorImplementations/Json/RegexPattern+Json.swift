extension RegexPattern {
    public static let json = RegexPattern(#"(\{|\}|\(|\)|\[|\]|,|"[^"]*"\s*:|"[^"]*")"#, type: .plain)
}
