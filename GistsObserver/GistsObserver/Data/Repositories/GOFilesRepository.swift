import Foundation

final class GOFilesRepository {
    
    private let networkService: GONetworkServiceProtocol
    
    init(networkService: GONetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}

extension GOFilesRepository: GODownloadFileRepositoryProtocol {
    
    func downloadFile(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        networkService.get(endpoint: path, callback: callback)
    }
    
}
