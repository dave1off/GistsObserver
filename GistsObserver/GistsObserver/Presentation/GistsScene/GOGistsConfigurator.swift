import Foundation

protocol GOGistsConfiguratorProtocol {
    
    func configure(view: GOGistsViewImplementation)
    
}

class GOGistsConfiguratorImplementation: GOGistsConfiguratorProtocol {

    func configure(view: GOGistsViewImplementation) {
        let gistsRepository = GOGistsRepository(networkService: GONetworkService.shared)
        let getPublicGistsUseCase = GOGetPublicGistsUseCaseImplementation(repository: gistsRepository)
        
        let imagesRepository = GOImagesRepository(networkService: GONetworkService.shared)
        let imageDownloadUseCase = GODownloadImageUseCaseImplementation(repository: imagesRepository)
        let addImagesUseCase = GOAddImagesToRepositoryUseCaseImplementation(repository: imagesRepository)
        
        let gistsPresenter = GOGistsPresenterImplementation(
            getGistsUseCase: getPublicGistsUseCase,
            downloadImageUseCase: imageDownloadUseCase,
            addImagesUseCase: addImagesUseCase,
            view: view
        )
        
        let gistsRouter = GOGistsRouterImplementation(view: view)
        
        view.presenter = gistsPresenter
        view.router = gistsRouter
    }
    
}
