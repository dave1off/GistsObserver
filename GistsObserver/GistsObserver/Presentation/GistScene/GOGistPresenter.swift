import Foundation

protocol GOGistPresenterProtocol {
    
    func onViewDidLoad()
    
}

class GOGistPresenterImplementation: GOGistPresenterProtocol {
    
    private let getGistUseCase: GOGetGistUseCaseProtocol
    private let downloadImageUseCase: GODownloadImageUseCaseProtocol
    private let gistID: String
    
    private weak var view: GOGistViewProtocol?
    
    init(
        gistID: String,
        getGistUseCase: GOGetGistUseCaseProtocol,
        downloadImageUseCase: GODownloadImageUseCaseProtocol,
        view: GOGistViewProtocol
    ) {
        self.gistID = gistID
        self.getGistUseCase = getGistUseCase
        self.downloadImageUseCase = downloadImageUseCase
        
        self.view = view
    }
    
    func onViewDidLoad() {
        getGistUseCase.getGist(id: gistID) { domainGist, error in
            guard let gist = domainGist, error == nil else {
                self.view?.loadingFailure()
                return
            }
            
            self.downloadImageUseCase.downloadImage(at: gist.owner.avatarURL) { data, error in
                guard let imageData = data, error == nil else {
                    self.view?.loadingFailure()
                    return
                }
                
                let viewModel = GOGistDescriptionViewModel(
                    id: gist.id,
                    authorAvatar: imageData,
                    name: gist.name,
                    authorName: gist.owner.login,
                    description: gist.description,
                    comments: gist.comments,
                    files: gist.files.map { $0.value }
                )
                
                GOExecutor.executeOnMain {
                    self.view?.infoLoaded(gist: viewModel)
                }
            }
        }
    }
    
}
