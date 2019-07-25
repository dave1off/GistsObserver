import Foundation

protocol GOGetGistUseCaseProtocol {
    
    func getGist(id: String, callback: @escaping (GOGistDomainModel?, Error?) -> ())
    
}

class GOGetGistUseCaseImplementation: GOGetGistUseCaseProtocol {
    
    private let repository: GOGetGistRepositoryProtocol
    
    init(repository: GOGetGistRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGist(id: String, callback: @escaping (GOGistDomainModel?, Error?) -> ()) {
        repository.getGist(id: id, callback: callback)
    }
    
}
