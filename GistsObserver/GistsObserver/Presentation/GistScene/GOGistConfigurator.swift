import Foundation

protocol GOGistConfiguratorProtocol {
    
    func configure(view: GOGistViewImplementation)
    
}

class GOGistConfiguratorImplementation: GOGistConfiguratorProtocol {
    
    private let gistID: String
    
    init(id: String) {
        self.gistID = id
    }
    
    func configure(view: GOGistViewImplementation) {
        let gistsRepository = GOGistsRepository(networkService: GONetworkService.shared)
        let getGistUseCase = GOGetGistUseCaseImplementation(repository: gistsRepository)
        
        let imagesRepository = GOImagesRepository(networkService: GONetworkService.shared)
        let imageDownloadUseCase = GODownloadImageUseCaseImplementation(repository: imagesRepository)
        
        let gistsPresenter = GOGistPresenterImplementation(
            gistID: gistID,
            getGistUseCase: getGistUseCase,
            downloadImageUseCase: imageDownloadUseCase,
            view: view
        )
        
        let gistsRouter = GOGistRouterImplementation(view: view)
        
        view.presenter = gistsPresenter
        view.router = gistsRouter
    }
    
}
