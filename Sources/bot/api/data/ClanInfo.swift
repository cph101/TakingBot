import DiscordKitCore

struct Clan: Decodable {
    let name: String
    let invite: String
    let id: Int
    let more: ExtendedInfo? = nil

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        invite = try values.decode(String.self, forKey: .invite)
        id = try values.decode(Int.self, forKey: .id)
    }

    private init(_ name: String, _ invite: String, _ id: Int) {
        self.name = name
        self.invite = invite
        self.id = id
    }

    func fetchExtended() -> Self {
        return self
    }

    enum CodingKeys: String, CodingKey {
        case name
        case invite
        case id
        case more
    }

    struct ExtendedInfo: Decodable {
        let icon: String
        let members: UInt8
    }
}