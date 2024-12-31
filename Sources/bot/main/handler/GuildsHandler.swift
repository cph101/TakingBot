import DiscordKitBot

class GuildsHandler: TexComHandler {

    override func matchablePresentation() -> MatchablePresentation {
        return MatchablePresentation.Builder("guilds")
            .build()
    }

    override func handle(_ data: BotMessage) async {
        try? await data.reply("test")
    }
}