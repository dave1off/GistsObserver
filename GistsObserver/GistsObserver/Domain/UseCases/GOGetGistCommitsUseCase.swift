import Foundation

protocol GOGetGistCommitsUseCaseProtocol {
    
    func getCommits(id: String, callback: @escaping ([GOCommitDomainModel]?, Error?) -> ())
    
}

class GOGetGistCommitsUseCaseImplementation: GOGetGistCommitsUseCaseProtocol {
    
    private let repository: GOGetGistCommitsRepositoryProtocol
    
    init(repository: GOGetGistCommitsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCommits(id: String, callback: @escaping ([GOCommitDomainModel]?, Error?) -> ()) {
        repository.getCommits(id: id, callback: callback)
    }
    
}
