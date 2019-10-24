// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "DictionaryCoding",
    products: [
        .library(
            name: "DictionaryCoding",
            targets: ["DictionaryCoding"]),
    ],
    dependencies: [
    ],
    targets: [
            .target(
            name: "DictionaryCoding",
            dependencies: []),
        .testTarget(
            name: "DictionaryCodingTests",
            dependencies: ["DictionaryCoding"]),
    ],
    swiftLanguageVersions: [.version("5.1")]
)
