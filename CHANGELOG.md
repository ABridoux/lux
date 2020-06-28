# Lux

All notable changes to this project will be documented in this file. `Lux` adheres to [Semantic Versioning](http://semver.org).

---
## [0.3.2](https://github.com/ABridoux/lux/tree/0.3.2) (27/06/2020)

### Added
- Dracula theme [#47]

### Changed
- Injector delegates refactoring [#44]

### Fixed
- `TerminalOutputFormat` delegate not set at initialisation [#47]

## [0.3.1](https://github.com/ABridoux/lux/tree/0.3.1) (26/06/2020)

### Fixed
- Hotfix to mark injection functions as `open`

## [0.3.0](https://github.com/ABridoux/lux/tree/0.3.0) (26/06/2020)

### Added
- Zsh support [#14]
- Swift Support (using [Splash](https://github.com/JohnSundell/Splash) [#38]

### Changed
- Refactoring of the Injectors. Phantom type InjectorType to offer 3 types: terminal, html, and app.

## [0.2.1](https://github.com/ABridoux/lux/tree/0.2.1) (19/06/2020)

## Fixed

- XML regular expression prevented to correclty categorise a key with a tag character (e.g. &, <, >) inside quotes.

## [0.2.0](https://github.com/ABridoux/lux/tree/0.2.0) (28/05/2020)

## Added

- Several Injectors support for `FileInjectionService` [#26] 

## Changed

- Injectors language identifiers [#25]
- XML enhanced closing tag with punctuation [#26]

## [0.1.1](https://github.com/ABridoux/lux/tree/0.1.1) (20/05/2020)

## Fixed

- Json key names with spaces before the `:` were not properly parsed

## [0.1.0](https://github.com/ABridoux/lux/tree/0.1.0) (20/05/2020)

Initial release
