public extension RegexPattern {
    static let htmlXml = RegexPattern(#"&lt;("[^"]*"|'[^']*'|[^&]*)+&gt;"#, type: .html)
    static let plainXml = RegexPattern(#"<("[^"]*"|'[^']*'|[^<^>])+>"#, type: .plain)
}
