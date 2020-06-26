open class XMLEnhancedDelegate: InjectorDelegate<XMLEnhancedCategory> {

    override open func inject<Output: Appendable, Injection: InjectionType>(_ category: XMLEnhancedCategory, in injectorType: InjectorType<Output, Injection>, _ match: String) -> Output {
        switch category {

        case .openingTag(let tag), .closingTag(let tag):

            let punctuationMark = self.injection(for: .punctuation, in: injectorType)
            let tagMark: Injection

            var openingBracket = injectorType.textType.openingBracket
            if case XMLEnhancedCategory.closingTag = category {
                tagMark = self.injection(for: .closingTag(tag), in: injectorType)
                openingBracket.append("/") // add the closing slash for closing tags
            } else {
                tagMark = injection(for: .openingTag(tag), in: injectorType)
            }

            let closingBracket = injectorType.textType.closingBracket

            var injectedOutput = injectorType.inject(punctuationMark, in: openingBracket)
            injectedOutput += injectorType.inject(tagMark, in: tag)
            injectedOutput += injectorType.inject(punctuationMark, in: closingBracket)

            return injectedOutput

        default:
            return super.inject(category, in: injectorType, match)
        }
    }
}
