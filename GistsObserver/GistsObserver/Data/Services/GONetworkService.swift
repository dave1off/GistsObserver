import Foundation

public enum GONetworkServiceError: Error {
    
    case invalidRequestURL(String)
    case somethingWetWrong
    
}

final class GONetworkService {
    
    static let shared = GONetworkService()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private var baseURLComponentns: URLComponents {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api.github.com"
        
        return components
    }
    
    private init() { }

}

extension GONetworkService: GONetworkServiceProtocol {
    
    func getRequest<T: Decodable>(
        _ type: T.Type,
        path: String,
        parameters: [String: String]?,
        callback: @escaping (T?, Error?) -> ()
    ) {
        var urlComponents = baseURLComponentns
        
        urlComponents.path = path
        
        if let params = parameters {
            urlComponents.queryItems = []
            
            for (name, value) in params {
                urlComponents.queryItems?.append(URLQueryItem(name: name, value: value))
            }
        }
        
        guard let url = urlComponents.url else {
            callback(nil, GONetworkServiceError.invalidRequestURL(urlComponents.string ?? ""))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { data, response, error in
            guard let dataResponse = data, error == nil else {
                callback(nil, GONetworkServiceError.somethingWetWrong)
                return
            }
            
            guard let result = try? self.decoder.decode(T.self, from: dataResponse) else {
                callback(nil, GONetworkServiceError.somethingWetWrong)
                return
            }
            
            callback(result, nil)
        }.resume()
    }
    
    func get(endpoint: String, callback: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: endpoint) else {
            callback(nil, GONetworkServiceError.invalidRequestURL(endpoint))
            return
        }
        
        session.dataTask(with: URLRequest(url: url)) { data, _, error in
            callback(data, error)
        }.resume()
    }
    
}
