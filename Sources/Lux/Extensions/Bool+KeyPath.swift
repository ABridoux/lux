func ~=<T>(lhs: KeyPath<T, Bool>, rhs: T) -> Bool {
    rhs[keyPath: lhs]
}
