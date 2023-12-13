import Foundation

public func decodeData(_ data: Data) throws -> MagicCards {
    let decoder = JSONDecoder()
    let result = try decoder.decode(MagicCards.self, from: data)
    return result
}

public func getData(urlRequest: String) {
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
                        printInfoAboutCard(card: item)
                    }

                }
            } catch {
                print("Ошибка декодирования.")
            }

        }
    }.resume()
}

public func printInfoAboutCard(card: ParametrCard) {
    print("""
Название карты: \(card.name)
Тип карты: \(card.type)
Преобразованная стоимость маны: \(card.cmc)
Редкость карты: \(card.rarity)
Набор: \(card.cardSet)
Автор карты: \(card.artist)
ID: \(card.artist)
----------------------------------------------
""")
}
