import Foundation
import DiscordKitBot

class TexComHandler: EventHandler {
    required init() {}
    
    func handle(_ data: BotMessage) async {
        fatalError("Subclasses must implement the handle(_:) method")
    }

    
    func matchablePresentation() -> MatchablePresentation {
        fatalError("Subclasses must implement the matchablePresentation method")
    }

    func canHandle(_ data: BotMessage) -> Bool {
        guard let regex = matchablePresentation().buildRegex() else {
            print("Failed to build regex")
            return false
        }

        let range = NSRange(data.content.startIndex..<data.content.endIndex, in: data.content)
        return regex.firstMatch(in: data.content, options: [], range: range) != nil
    }


    final func listener() -> NCWrapper<BotMessage> {
        return TakingBot.client.messageCreate;
    }
}