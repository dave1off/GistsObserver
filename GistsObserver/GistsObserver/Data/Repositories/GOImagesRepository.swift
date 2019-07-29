import Foundation

final class GOImagesRepository {
    
    private let networkService: GONetworkServiceProtocol
    
    private var cache: [String: Data] = [:]
    
    init(networkService: GONetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}

extension GOImagesRepository: GODownloadImageRepositoryProtocol {
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        networkService.get(endpoint: path) { data, error in
            guard let imageData = data, error == nil else {
                callback(data, error)
                return
            }
            
            self.cache[path] = imageData
            
            callback(imageData, nil)
        }
    }
    
}

extension GOImagesRepository: GOFetchImageRepositoryProtocol {
    
    func fetchImage(at path: String, callback: @escaping (Data?, Error?) -> Void) {
        guard cache[path] == nil else {
            callback(cache[path], nil)
            return
        }
        
        downloadImage(at: path, callback: callback)
    }
    
}
