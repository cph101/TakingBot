// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "TakingBot",
    platforms: [
       .macOS(.v13)
    ],
    products: [
        .executable(name: "TakingBot", targets: ["bot"]),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "bot",
            dependencies: []
        )
    ],
    swiftLanguageModes: [.v5]
)