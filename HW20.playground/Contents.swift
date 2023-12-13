import Foundation

class ManagerCard {
    let path: String
    let host: String
    let queryItem: [URLQueryItem]

    init(path: String, host: String, queryItem: [URLQueryItem]) {
        self.path = path
        self.host = host
        self.queryItem = queryItem
    }

    func createURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItem
        return components.url
    }
}

let opt = ManagerCard(path: "/v1/cards", host: "api.magicthegathering.io", queryItem: queryItemOpt)
if let urlOpt = opt.createURL()?.absoluteString {
    getData(urlRequest: urlOpt)
}

let blackLotus = ManagerCard(path: "/v1/cards", host: "api.magicthegathering.io", queryItem: queryItemBlackLotus)
if let urlBlackLotus = blackLotus.createURL()?.absoluteString {
    getData(urlRequest: urlBlackLotus)
}


