import Foundation

protocol GONetworkServiceProtocol {
    
    func getRequest<T: Decodable>(
        _ type: T.Type,
        path: String,
        parameters: [String: String]?,
        callback: @escaping (T?, Error?) -> ()
    )
    
    func get(endpoint: String, callback: @escaping (Data?, Error?) -> ())
    
}
