import Foundation

struct MagicCards: Codable {
    let cards: [ParametrCard]
}

struct ParametrCard: Codable {
    let name: String
    let type: String
    let cmc: Int
    let rarity: String
    let cardSet: String
    let artist: String
    let id: String

    enum CodingKeys: String, CodingKey {
            case name, type, cmc, rarity
            case cardSet = "set"
            case artist, id
        }
}


func createURL(host: String,
                       path: String,
                       queryItem: [URLQueryItem]? = nil) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    components.queryItems = queryItem
    return components.url
}


func decodeData(_ data: Data) throws -> MagicCards {
    let decoder = JSONDecoder()
    let result = try decoder.decode(MagicCards.self, from: data)
    return result
}

func getData(urlRequest: String) {
    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else {
        print("Неверный формат ссылки")
        return }
    URLSession.shared.dataTask(with: url) { data, responce, error in
        if error != nil {
            print("Error: \(String(describing: error))")
        } else if let responce = responce as? HTTPURLResponse {
            switch responce.statusCode {
            case 200:
                print("Успешно.")
            default:
                print("Код ответа: \(responce.statusCode)")
            }

            guard let data = data else { return }


            do {
                let result = try decodeData(data)
                if !result.cards.isEmpty {
                    for item in result.cards {
                        print("""
    Название карты: \(item.name)
    Тип карты: \(item.type)
    Преобразованная стоимость маны: \(item.cmc)
    Редкость карты: \(item.rarity)
    Набор: \(item.cardSet)
    Автор карты: \(item.artist)
    ID: \(item.artist)
    ----------------------------------------------
    """)
                    }

                }
            } catch {
                print("Ошибка декодирования.")
            }

        }
    }.resume()
}


let path = "/v1/cards"
let host = "api.magicthegathering.io"
let queryItemOpt = [URLQueryItem(name: "name", value: "Opt")]
let queryItemBlackLotus = [URLQueryItem(name: "name", value: "Black Lotus")]

let urlMy = createURL(host: host, path: path, queryItem: queryItemOpt)?.absoluteString

getData(urlRequest: urlMy ?? "https://api.magicthegathering.io/v1/cards")


