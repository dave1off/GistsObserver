final class GOGistsRepository {
    
    private let networkService: GONetworkServiceProtocol
    
    init(networkService: GONetworkServiceProtocol) {
        self.networkService = networkService
    }

}

extension GOGistsRepository: GOGetPublicGistsRepositoryProtocol {
    
    func getPublicGists(page: UInt64, perPage: UInt64, callback: @escaping ([GOGistDomainModel]?, Error?) -> ()) {
        networkService.getRequest(
            [GOGetGistsRequestModel].self,
            path: "/gists/public",
            parameters: [
                "page": page.description,
                "per_page": perPage.description
            ]
        ) { requestGists, error in
            guard let gists = requestGists, error == nil else {
                callback(nil, error)
                return
            }
            
            let domainGists = gists.map { GOGetGistsRequestModel.domainModel(from: $0) }
            
            callback(domainGists, nil)
        }
    }
    
}

extension GOGistsRepository: GOGetGistRepositoryProtocol {
    
    func getGist(id: String, callback: @escaping (GOGistDomainModel?, Error?) -> ()) {
        networkService.getRequest(
            GOGetGistsRequestModel.self,
            path: "/gists/\(id)",
            parameters: nil
        ) { requestGist, error in
            guard let gist = requestGist, error == nil else {
                callback(nil, error)
                return
            }
            
            let domainGist = GOGetGistsRequestModel.domainModel(from: gist)
            
            callback(domainGist, nil)
        }
    }
    
}

extension GOGistsRepository: GOGetGistCommitsRepositoryProtocol {
    
    func getCommits(id: String, callback: @escaping ([GOCommitDomainModel]?, Error?) -> ()) {
        networkService.getRequest(
            [GOGistCommitNetworkModel].self,
            path: "/gists/\(id)/commits",
            parameters: nil
        ) { requestCommits, error in
            guard let commits = requestCommits, error == nil else {
                callback(nil, error)
                return
            }
            
            let domainCommits = commits.map { GOGistCommitNetworkModel.domainModel(from: $0) }
            
            callback(domainCommits, nil)
        }
    }
    
}
