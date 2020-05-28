open class XMLEnhancedDelegate: InjectorDelegate<XMLEnhancedCategory> {

    override open func inject(_ category: XMLEnhancedCategory, in type: TextType, _ match: String) -> String {
        switch category {

        case .openingTag(let tag), .closingTag(let tag):

            let punctuationMark = injection(for: .punctuation, type: type)
            let tagMark: String

            var openingBracket = type.openingBracket
            if case XMLEnhancedCategory.closingTag = category {
                tagMark = injection(for: .closingTag(tag), type: type)
                openingBracket.append("/") // add the closing slash for closing tags
            } else {
                tagMark = injection(for: .openingTag(tag), type: type)
            }

            let closingBracket = type.closingBracket

            var modifiedText = InjectionService.inject(punctuationMark, in: type, openingBracket) // opening bracket
            modifiedText += InjectionService.inject(tagMark, in: type, tag) // tag name
            modifiedText += InjectionService.inject(punctuationMark, in: type, closingBracket) // closing bracket

            return modifiedText
        default:
            return super.inject(category, in: type, match)
        }
    }

    override open func inject(category: XMLEnhancedCategory, _ match: String) -> AttributedString {

        switch category {

        case .openingTag(let tag), .closingTag(let tag):
            var openingBracketString = TextType.plain.openingBracket

            var tagColor: Color

            if case XMLEnhancedCategory.closingTag = category {
                tagColor = self.color(for: .closingTag(tag))
                openingBracketString.append("/") // add the closing slash for closing tags
            } else {
                tagColor = self.color(for: .openingTag(tag))
            }

            var openingBracket = AttributedString(openingBracketString)
            openingBracket.textColor = self.color(for: .punctuation)
            var tagAttrString = AttributedString(tag)
            tagAttrString.textColor = tagColor
            var closingBracket = AttributedString(TextType.plain.closingBracket)
            closingBracket.textColor = self.color(for: .punctuation)

            let modifiedAttrString = openingBracket
            modifiedAttrString.append(tagAttrString)
            modifiedAttrString.append(closingBracket)

            return modifiedAttrString

        default:
            return super.inject(category: category, match)
        }
    }
}
