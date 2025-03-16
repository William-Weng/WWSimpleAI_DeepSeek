// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWSimpleAI_DeepSeek",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "WWSimpleAI_DeepSeek", targets: ["WWSimpleAI_DeepSeek"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWSimpleAI_Ollama", from: "1.0.0")
    ],
    targets: [
        .target(name: "WWSimpleAI_DeepSeek", dependencies: ["WWSimpleAI_Ollama"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
