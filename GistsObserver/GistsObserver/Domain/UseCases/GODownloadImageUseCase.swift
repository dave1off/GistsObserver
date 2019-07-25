import Foundation

protocol GODownloadImageUseCaseProtocol {
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ())
    
}

class GODownloadImageUseCaseImplementation: GODownloadImageUseCaseProtocol {
    
    private let repository: GODownloadImageRepositoryProtocol
    
    init(repository: GODownloadImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        repository.downloadImage(at: path, callback: callback)
    }
    
}
