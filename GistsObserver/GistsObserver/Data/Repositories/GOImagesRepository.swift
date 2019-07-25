import Foundation

final class GOImagesRepository {
    
    private let networkService: GONetworkServiceProtocol
    
    init(networkService: GONetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}

extension GOImagesRepository: GODownloadImageRepositoryProtocol {
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        networkService.get(endpoint: path) { data, response, error in
            callback(data, error)
        }
    }
    
}
