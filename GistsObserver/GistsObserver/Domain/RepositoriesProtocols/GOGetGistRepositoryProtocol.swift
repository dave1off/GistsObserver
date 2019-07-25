import Foundation

protocol GOGetGistRepositoryProtocol {
    
    func getGist(id: String, callback: @escaping (GOGistDomainModel?, Error?) -> ())
    
}
