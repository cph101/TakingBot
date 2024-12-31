import Foundation
import DiscordKitBot

protocol EventHandler: AnyObject {
    associatedtype handledType

    init()
    func handle(_ data: handledType) async
    func canHandle(_ data: handledType) -> Bool
    func listener() -> NCWrapper<handledType>
}