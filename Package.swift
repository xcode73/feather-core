// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-core",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Feather", targets: ["Feather"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.3"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.9.0"),
        .package(url: "https://github.com/binarybirds/liquid.git", from: "1.3.2"),
        .package(url: "https://github.com/binarybirds/mail.git", from: "0.0.2"),
        .package(url: "https://github.com/binarybirds/swift-html.git", from: "1.7.0"),
        .package(url: "https://github.com/xcode73/feather-objects.git", branch: "test-dev"),
        .package(url: "https://github.com/xcode73/feather-icons.git", branch: "test-dev"),
        .package(url: "https://github.com/binarybirds/spec.git", from: "1.2.0")
    ],
    targets: [
        .target(name: "Feather", dependencies: [
            .product(name: "Vapor", package: "vapor"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "Liquid", package: "liquid"),
            .product(name: "Mail", package: "mail"),
            .product(name: "SwiftHtml", package: "swift-html"),
            .product(name: "SwiftSvg", package: "swift-html"),
            .product(name: "SwiftRss", package: "swift-html"),
            .product(name: "SwiftSitemap", package: "swift-html"),
            .product(name: "FeatherIcons", package: "feather-icons"),
            .product(name: "FeatherObjects", package: "feather-objects")
        ], resources: [
            .copy("Modules/System/Bundle")
        ]),
        .target(name: "XCTFeather", dependencies: [
            .target(name: "Feather"),
            .product(name: "Spec", package: "spec")
        ]),
        
        // MARK: - test targets
        .testTarget(name: "FeatherTests", dependencies: [
            .target(name: "Feather")
        ]),
        .testTarget(name: "XCTFeatherTests", dependencies: [
            .target(name: "XCTFeather")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
