import Foundation

private func createURL(host: String, path: String, queryItem: [URLQueryItem]? = nil) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host
    components.path = path
    components.queryItems = queryItem
    return components.url
}

func getData () {
    
}
