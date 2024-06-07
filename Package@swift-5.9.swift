// swift-tools-version:5.9
import PackageDescription
import Foundation

let package = Package(
    name: "feather-core",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "FeatherCli", targets: ["FeatherCli"]),
        .library(name: "FeatherIcons", targets: ["FeatherIcons"]),
        .library(name: "FeatherCoreApi", targets: ["FeatherCoreApi"]),
        .library(name: "FeatherCoreSdk", targets: ["FeatherCoreSdk"]),
        .library(name: "FeatherCore", targets: ["FeatherCore"]),
//        .library(name: "XCTFeather", targets: ["XCTFeather"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.101.2"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.11.0"),
        .package(url: "https://github.com/BinaryBirds/liquid.git", from: "1.3.2"),
        .package(url: "https://github.com/BinaryBirds/swift-html.git", from: "1.7.0"),
//        .package(url: "https://github.com/BinaryBirds/swift-css.git", from: "1.0.1"),
//        .package(url: "https://github.com/BinaryBirds/vapor-spec.git", from: "2.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "FeatherCli",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .target(name: "FeatherCliGenerator"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .target(
            name: "FeatherIcons",
            dependencies: [
                .product(name: "SwiftSvg", package: "swift-html"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .target(
            name: "FeatherCliGenerator",
            dependencies: [],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .target(
            name: "FeatherCoreApi",
            dependencies: [],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .target(
            name: "FeatherCoreSdk",
            dependencies: [
                .target(name: "FeatherCoreApi"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .target(
            name: "FeatherCore",
            dependencies: [
                .target(name: "FeatherIcons"),
                .target(name: "FeatherCoreApi"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "Liquid", package: "liquid"),
                .product(name: "SwiftHtml", package: "swift-html"),
                .product(name: "SwiftSvg", package: "swift-html"),
                .product(name: "SwiftRss", package: "swift-html"),
                .product(name: "SwiftSitemap", package: "swift-html"),
                //            .product(name: "SwiftCss", package: "swift-css"),
            ],
            resources: [
                .copy("Bundle"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
//        .target(
//            name: "XCTFeather",
//            dependencies: [
//                .target(name: "FeatherCore"),
//                .product(name: "Spec", package: "spec"),
//            ],
//            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
//        ),
        .testTarget(
            name: "FeatherCoreTests",
            dependencies: [
                .target(name: "FeatherCore"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .testTarget(
            name: "FeatherCoreSdkTests",
            dependencies: [
                .target(name: "FeatherCoreSdk"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
        .testTarget(
            name: "FeatherCliGeneratorTests",
            dependencies: [
                .target(name: "FeatherCliGenerator"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
//        .testTarget(
//            name: "XCTFeatherTests",
//            dependencies: [
//                .target(name: "XCTFeather"),
//            ],
//            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
//        )
    ]
)
