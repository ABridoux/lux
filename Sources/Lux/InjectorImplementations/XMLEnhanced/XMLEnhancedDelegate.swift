open class XMLEnhancedDelegate: InjectorDelegate<XMLEnhancedCategory> {

    override open func inject(_ category: XMLEnhancedCategory, in type: TextType, _ match: String) -> String {
        if case let XMLEnhancedCategory.openingTag(tag) = category {

            let punctuationMark = injection(for: .punctuation, type: type)
            let openingTagMark = injection(for: .openingTag(tag), type: type)

            let openingBracket = type.openingBracket
            let closingBracket = type.closingBracket

            var modifiedText = InjectionService.inject(punctuationMark, in: type, openingBracket) // opening bracket
            modifiedText += InjectionService.inject(openingTagMark, in: type, tag) // tag name
            modifiedText += InjectionService.inject(punctuationMark, in: type, closingBracket) // closing bracket

            return modifiedText
        } else {
            return super.inject(category, in: type, match)
        }
    }

    override open func inject(category: XMLEnhancedCategory, _ match: String) -> AttributedString {
        if case let XMLEnhancedCategory.openingTag(tag) = category {

            var openingBracket = AttributedString(TextType.plain.openingBracket)
            openingBracket.textColor = self.color(for: .punctuation)
            var tagAttrString = AttributedString(tag)
            tagAttrString.textColor = self.color(for: .openingTag(tag))
            var closingBracket = AttributedString(TextType.plain.closingBracket)
            closingBracket.textColor = self.color(for: .punctuation)

            let modifiedAttrString = openingBracket
            modifiedAttrString.append(tagAttrString)
            modifiedAttrString.append(closingBracket)

            return modifiedAttrString
        } else {
            return super.inject(category: category, match)
        }
    }
}
