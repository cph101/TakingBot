import Foundation
import DiscordKitBot

extension NCWrapper: @retroactive Identifiable, @retroactive Hashable {
    public var id: UUID {
        return UUID()
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: NCWrapper, rhs: NCWrapper) -> Bool {
        return lhs.id == rhs.id
    }

}
