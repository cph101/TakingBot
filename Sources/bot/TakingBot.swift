import Foundation
import DiscordKitBot

@main
class TakingBot {

    static let client = Client()

    static func main() {

        client.ready.listen {
            print("Logged in as \(client.user!.username)#\(client.user!.discriminator)!")
        }

        EventDispatcher.load()
        
        client.login(token: "MTMxNzA2NDY2ODg5MTcxMzU3OA.GMhapI.f2XDKwYLJsSRBTM_bpz_koa1PHKL5yvvSIaBok")
        RunLoop.main.run()
    }
}