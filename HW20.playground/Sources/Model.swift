import Foundation

public struct MagicCards: Codable {
    public let cards: [ParametrCard]
}

public struct ParametrCard: Codable {
    public let name: String
    public let type: String
    public let cmc: Int
    public let rarity: String
    public let cardSet: String
    public let artist: String
    public let id: String

    enum CodingKeys: String, CodingKey {
            case name, type, cmc, rarity
            case cardSet = "set"
            case artist, id
        }
}

public let queryItemOpt = [URLQueryItem(name: "name", value: "Opt")]
public let queryItemBlackLotus = [URLQueryItem(name: "name", value: "Black Lotus")]


