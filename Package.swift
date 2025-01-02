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
        .package(url: "https://github.com/cph101/DiscordKit", branch: "main")
    ],
    targets: [
        .executableTarget(
            name: "bot",
            dependencies: [
                .product(name: "DiscordKitBot", package: "discordkit")
            ],
            resources: [
                .process("resources/Clans.plist")
            ]
        )
    ],
    swiftLanguageModes: [.v5]
)