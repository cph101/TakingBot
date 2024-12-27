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
        .package(url: "https://github.com/SwiftcordApp/DiscordKit", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "bot",
            dependencies: [
                .product(name: "DiscordKitBot", package: "discordkit")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)