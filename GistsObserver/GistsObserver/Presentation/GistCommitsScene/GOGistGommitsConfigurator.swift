import Foundation

protocol GOGistGommitsConfiguratorProtocol {
    
    func configure(view: GOGistCommitsViewImplementation)
    
}

class GOGistGommitsConfiguratorImplementation: GOGistGommitsConfiguratorProtocol {
    
    private let gistID: String
    
    init(id: String) {
        self.gistID = id
    }
    
    func configure(view: GOGistCommitsViewImplementation) {
        let gistsRepository = GOGistsRepository(networkService: GONetworkService.shared)
        let gistCommitsUseCase = GOGetGistCommitsUseCaseImplementation(repository: gistsRepository)
        
        let gistCommitsPresenter = GOGistCommitsPresenterImplementation(
            getGistCommits: gistCommitsUseCase,
            gistID: gistID,
            view: view
        )
        
        let gistCommitsRouter = GOGistCommitsRouterImplementation(view: view)
        
        view.presenter = gistCommitsPresenter
        view.router = gistCommitsRouter
    }
    
}
