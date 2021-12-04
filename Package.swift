// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DLGenetic",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "DLGenetic",
            targets: ["DLGenetic"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dyerlab/DLMatrix", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DLGenetic",
            dependencies: ["DLMatrix"]),
        .testTarget(
            name: "DLGeneticTests",
            dependencies: ["DLGenetic", "DLMatrix"]),
    ]
)
