import Foundation
import DiscordKitBot

protocol TexComHandler: EventHandler {
    func handle(_ data: BotMessage) async
    func matchablePresentation() -> MatchablePresentation
}

extension TexComHandler {
    func canHandle(_ data: BotMessage) -> Bool {

        if matchablePresentation().buildRegex() == nil {
            print("Failed to build regex")
            return false
        }

        return matchablePresentation().matchesInput(data.content) != nil
    }


    func listener() -> NCWrapper<BotMessage> {
        return TakingBot.client.messageCreate;
    }
}