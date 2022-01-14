// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "DLabGenetic",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "DLabGenetic",
            targets: ["DLabGenetic"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dyerlab/DLabMatrix", .upToNextMajor(from: "1.0.3")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DLabGenetic",
            dependencies: ["DLabMatrix"]),
        .testTarget(
            name: "DLabGeneticTests",
            dependencies: ["DLabGenetic", "DLabMatrix"]),
    ]
)
