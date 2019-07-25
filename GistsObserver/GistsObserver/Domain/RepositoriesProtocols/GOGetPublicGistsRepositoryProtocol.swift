import Foundation

protocol GOGetPublicGistsRepositoryProtocol {

    func getPublicGists(page: UInt64, perPage: UInt64, callback: @escaping ([GOGistDomainModel]?, Error?) -> ())
    
}
