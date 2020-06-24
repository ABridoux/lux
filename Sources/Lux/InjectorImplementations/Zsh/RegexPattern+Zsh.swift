public extension RegexPattern {

    static let plainZsh = RegexPattern(
          #""[^"]*"|'[^']*'"# // strings
        + #"|\s?\x5C#[^\s]*|#.*(?=\n|\Z)"# // comments and escaped # signs
        + #"|(\s?sudo|\$\(|\$|\[|`|\n|\r|\|)\h*[a-zA-Z0-9]{1}[a-zA-Z0-9_-]*=?"# // programs and variables defs
        + #"|\s\h*[a-zA-Z0-9\/\.]{1}[^\s]*"# // commands and option values
        + #"|\s-{1,2}[a-zA-Z0-9_-]+"# // options and flags
        + #"|\$\{[a-zA-Z0-9_-]+\}|"# // variable with brackets ${variable}
        + #"\[|\]|;|\(|\)|\{|\}|`"#, // punctuation
        type: .plain)

    /// Find variables in a string in Zsh
    static let zshVariables = RegexPattern(
        #"\$[a-zA-Z0-9_-]+"#
        + #"|\$\{[a-zA-Z0-9_-]+\}"#,
        type: .plain)
}
