import Foundation

protocol GOGetGistCommitsRepositoryProtocol {
    
    func getCommits(id: String, callback: @escaping ([GOCommitDomainModel]?, Error?) -> ())
    
}
