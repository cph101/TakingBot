import DiscordKitBot
import Foundation

class EventDispatcher {
    private static var handlers: [any EventHandler.Type] = []

    public static func load() {
        registerHandlerType(GuildsHandler.self)

        subscribeEvents()
    }

    private static func registerHandlerType<T: EventHandler>(_ handlerType: T.Type) {
        handlers.append(handlerType)
    }

    private static func subscribeEvents() {
        for handlerType in handlers {
            let handler = handlerType.init()
            subscribeListener(handler)
        }
    }

    private static func subscribeListener<T: EventHandler>(_ handler: T) {
        handler.listener().listen { event in
            if (handler.canHandle(event)) {
                Task {
                    await handler.handle(event)
                }
            }
        }
    }
}