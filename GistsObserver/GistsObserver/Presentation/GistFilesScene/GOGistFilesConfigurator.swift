import Foundation

protocol GOGistFilesConfiguratorProtocol {
    
    func configure(view: GOGistFilesViewImplementation)
    
}

class GOGistFilesConfiguratorImplementation: GOGistFilesConfiguratorProtocol {
    
    private let files: [GOFileDomainModel]
    
    init(files: [GOFileDomainModel]) {
        self.files = files
    }
    
    func configure(view: GOGistFilesViewImplementation) {
        let filesRepository = GOFilesRepository(networkService: GONetworkService.shared)
        let getFilesUseCase = GODownloadFileUseCaseImplementation(repository: filesRepository)
        
        let gistCommitsPresenter = GOGistFilesPresenterImplementation(
            downloadFileUseCase: getFilesUseCase,
            files: files,
            view: view
        )
        
        let gistCommitsRouter = GOBackRouterImplementation(view: view)
        
        view.presenter = gistCommitsPresenter
        view.router = gistCommitsRouter
    }
    
}
