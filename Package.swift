// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Codable",
    products: [
        .executable(
            name: "Example",
            targets: ["Example"]),
        .library(name: "Codable",
                 targets: ["Codable"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "Example",
            dependencies: [
                "Codable",
            ]),
        .testTarget(
            name: "CodableTests",
            dependencies: ["Example"]),
        .target(
            name: "Codable",
            dependencies: [
            ]),
    ])
