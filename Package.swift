// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lux",
    platforms: [.macOS("10.13"), .iOS("10.0")],
    products: [
        .library(
            name: "Lux",
            targets: ["Lux"]),
        .executable(
            name: "LuxCLT",
            targets: ["LuxCLT"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "0.0.1"),
        .package(
            url: "https://github.com/scinfu/SwiftSoup.git",
            from: "1.7.4"),
        .package(
            url: "https://github.com/JohnSundell/Splash",
            from: "0.15.0")
    ],
    targets: [
        .target(
            name: "Lux",
            dependencies: ["Splash", "SwiftSoup"]),
        .target(
            name: "LuxCLT",
            dependencies: ["Lux", "ArgumentParser"]),
        .testTarget(
            name: "LuxTests",
            dependencies: ["Lux"]),
    ]
)
