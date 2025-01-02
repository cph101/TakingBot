import Foundation
import DiscordKitBot
import DiscordKitCore

class GuildsHandler: TexComHandler {

    required init() {}

    func matchablePresentation() -> MatchablePresentation {
        return MatchablePresentation.Builder("guilds")
            .addFlag(["anonymous", "anon"])
            .addFlag(["other", "more"])
            .build()
    }

    func handle(_ data: BotMessage) async {
        guard let maybeMatch = matchablePresentation().matchesInput(data.content) else {
            return;
        }

        guard let rest = data.getREST() else { return; }

        let anonymous = matchablePresentation().extractFlag(matched: maybeMatch, flagAlias: "anon", from: data.content)

        var embed = BotEmbed()
                .color(0xFFFFFF)
                .title("GUILDS")

        embed = embed.description(
            Clans.allClans()
                .enumerated()
                .reduce("") { partial, item in
                    let (index, clan) = item
                    return partial 
                        + (partial.isEmpty ? "" : "\n") 
                        + """
                        **`#\(index)`** **`\(clan.name.uppercased())`** (`\(clan.id)`) - **[Apply](https://discord.gg/\(clan.invite))**
                        """
                }
        )

        if (anonymous) {
            Task {
                try? await rest.deleteMsg(id: data.channelID, msgID: data.id)
            }
            try! await rest.createChannelMsg(message: NewMessage(
                content: nil, nonce: .init(), tts: true, embeds: [embed.toEmbed()],
                 allowed_mentions: nil, message_reference: nil, components: nil, 
                 sticker_ids: nil, attachments: nil, flags: 0
            ), id: data.channelID)

        } else {
            try! await data.reply([embed.toEmbed()])
        }
    }

    /*{
            BotEmbed()
                .color(0xFFFFFF)
                .description("test text")
                .title("test")
        }*/

}