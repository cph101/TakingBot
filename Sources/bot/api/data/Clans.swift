import Foundation

class Clans {

    static var clans: [ClanInfo] = []
    static var lastUpdated = NSDate().timeIntervalSince1970
    
    static func allClans() -> [ClanInfo] {
        let cacheTime = NSDate().timeIntervalSince1970 - lastUpdated
        if clans.count > 0 && cacheTime < 3600 {
            return clans
        }

        guard let url = Bundle.main.url(forResource: "TakingBot_bot.resources/Clans", withExtension: "plist"),
            let data = try? Data(contentsOf: url) else {
                print("Failed to load plist file.")
            return []
        }
        
        let decoder = PropertyListDecoder()
        let clansFresh = (try? decoder.decode([ClanInfo].self, from: data)) ?? []
        clans = clansFresh; return clans
    }
}