// swift-tools-version:5.9

import PackageDescription

var package = Package(
    name: "IBLinter",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "iblinter", targets: ["IBLinter"]
        ),
        .library(
            name: "IBLinterFrontend",
            type: .dynamic, targets: ["IBLinterFrontend"]
        ),
        .library(
            name: "IBLinterKit", targets: ["IBLinterKit"]
        ),
        .executable(
            name: "iblinter-tools", targets: ["IBLinterTools"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/lt-aoyama/IBDecodable.git", from: "0.6.1"),
        .package(url: "https://github.com/jpsim/SourceKitten.git", from: "0.35.0"),
        .package(url: "https://github.com/phimage/XcodeProjKit.git", from: "2.2.0"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.1"),
    ],
    targets: [
        .target(
            name: "IBLinter",
            dependencies: ["IBLinterFrontend"]
        ),
        .target(
            name: "IBLinterFrontend",
            dependencies: ["IBLinterKit"]
        ),
        .target(
            name: "IBLinterKit",
            dependencies: [
                "IBDecodable",
                .product(name: "SourceKittenFramework", package: "SourceKitten"), "XcodeProjKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "IBLinterTools",
            dependencies: ["IBLinterKit", .product(name: "ArgumentParser", package: "swift-argument-parser")]
        ),
        .testTarget(
            name: "IBLinterKitTest",
            dependencies: ["IBLinterKit"],
            exclude: [
                "Resources"
            ]
        ),
    ]
)

#if os(Linux)
package.dependencies.append(.package(url: "https://github.com/apple/swift-crypto.git", from: "1.0.0"))
package.targets[2].dependencies.append(.product(name: "Crypto", package: "swift-crypto"))
#endif
