import Foundation

protocol GOFetchImageUseCaseProtocol {
    
    func fetchImage(at path: String, callback: @escaping (Data?, Error?) -> Void)
    
}

class GOFetchImageUseCaseImplementation: GOFetchImageUseCaseProtocol {
    
    private let repository: GOFetchImageRepositoryProtocol
    
    init(repository: GOFetchImageRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchImage(at path: String, callback: @escaping (Data?, Error?) -> Void) {
        repository.fetchImage(at: path, callback: callback)
    }
    
}
