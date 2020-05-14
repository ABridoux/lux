extension RegexPattern {
    public static let json = RegexPattern(#"(\{|\}|\(|\)|\[|\]|,|"[^"]*":|"[^"]*")"#, type: .plain)
}
