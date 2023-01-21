// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NomadToolsX",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NomadToolsX",
            targets: ["NomadToolsX"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/yeahdongcn/UIColor-Hex-Swift", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/anomaddev/Cartography.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/malcommac/SwiftDate", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/ninjaprox/NVActivityIndicatorView.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/fahidattique55/FAPanels.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Skyscanner/SkyFloatingLabelTextField.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Yummypets/YPImagePicker.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/huri000/SwiftEntryKit.git", .upToNextMajor(from: "2.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NomadToolsX",
            dependencies: [
                .product(name: "UIColorHexSwift", package: "UIColor-Hex-Swift"),
                .product(name: "Cartography", package: "Cartography"),
                .product(name: "SwiftDate", package: "SwiftDate"),
                .product(name: "NVActivityIndicatorView", package: "NVActivityIndicatorView"),
                .product(name: "FAPanels", package: "FAPanels"),
                .product(name: "SkyFloatingLabelTextField", package: "SkyFloatingLabelTextField"),
                .product(name: "YPImagePicker", package: "YPImagePicker"),
                .product(name: "SwiftEntryKit", package: "SwiftEntryKit")
            ]
        ),
        .testTarget(
            name: "NomadToolsXTests",
            dependencies: ["NomadToolsX"]),
    ]
)
