import Foundation
import DiscordKitBot

@main
class TakingBot {

    static let client = Client(intents: .all)

    static func main() {

        client.ready.listen {
            print("Logged in as \(client.user!.username)#\(client.user!.discriminator)!")
        }

        EventDispatcher.load()
        
        client.login(token: "MTMxNzA2NDY2ODg5MTcxMzU3OA.G1mCF_.imC845FZuVYKmJhuZKQFzCtVfcZgytRJOsC_A8")
        RunLoop.main.run()
    }
}