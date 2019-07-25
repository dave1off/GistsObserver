import Foundation

protocol GODownloadFileUseCaseProtocol {
    
    func downloadFile(at path: String, callback: @escaping (Data?, Error?) -> ())
    
}

class GODownloadFileUseCaseImplementation: GODownloadFileUseCaseProtocol {
    
    private let repository: GODownloadFileRepositoryProtocol
    
    init(repository: GODownloadFileRepositoryProtocol) {
        self.repository = repository
    }
    
    func downloadFile(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        repository.downloadFile(at: path, callback: callback)
    }
    
}
