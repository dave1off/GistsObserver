import Foundation

protocol GOGetPublicGistsUseCaseProtocol {
    
    func getPublicGists(page: UInt64, perPage: UInt64, callback: @escaping ([GOGistDomainModel]?, Error?) -> ())
    
}

class GOGetPublicGistsUseCaseImplementation: GOGetPublicGistsUseCaseProtocol {
    
    private let repository: GOGetPublicGistsRepositoryProtocol
    
    init(repository: GOGetPublicGistsRepositoryProtocol) {
        self.repository = repository
    }

    func getPublicGists(page: UInt64, perPage: UInt64, callback: @escaping ([GOGistDomainModel]?, Error?) -> ()) {
        repository.getPublicGists(page: page, perPage: perPage, callback: callback)
    }
    
}
