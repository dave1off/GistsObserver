import Foundation

protocol GOGistsPresenterProtocol {
    
    func onViewDidLoad()
    func onDownloadImage()
    
    func onPrevPage()
    func onCurrentPage()
    func onNextPage()
    
}

class GOGistsPresenterImplementation: GOGistsPresenterProtocol {
    
    private let getGistsUseCase: GOGetPublicGistsUseCaseProtocol
    private let downloadImageUseCase: GODownloadImageUseCaseProtocol
    private let addImagesUseCase: GOAddImagesToRepositoryUseCaseProtocol
    
    private var gists: [GOGistDomainModel] = []
    
    private var page: UInt64 = 1
    private let perPage: UInt64 = 10
    
    let repository = GOImagesRepository(networkService: GONetworkService.shared)

    private weak var view: GOGistsViewProtocol?
    
    init(
        getGistsUseCase: GOGetPublicGistsUseCaseProtocol,
        downloadImageUseCase: GODownloadImageUseCaseProtocol,
        addImagesUseCase: GOAddImagesToRepositoryUseCaseProtocol,
        view: GOGistsViewProtocol
    ) {
        self.getGistsUseCase = getGistsUseCase
        self.downloadImageUseCase = downloadImageUseCase
        self.addImagesUseCase = addImagesUseCase
        
        self.view = view
    }
    
    func onViewDidLoad() {
        onCurrentPage()
    }
    
    func onNextPage() {
        reloadGists(page: page + 1, perPage: perPage)
    }
    
    func onPrevPage() {
        reloadGists(page: page - 1, perPage: perPage)
    }
    
    func onCurrentPage() {
        reloadGists(page: page, perPage: perPage)
    }
    
    func onDownloadImage() {
        let login = view?.userForAvatar ?? ""
        let link = gists.filter { $0.owner.login == login }.first?.owner.avatarURL ?? ""
        
        repository.fetchImage(at: link) { data, error in
            guard let imageData = data, error == nil else { return }
            
            GOExecutor.executeOnMain {
                self.view?.imageLoadedFor(data: imageData, user: login)
            }
        }
    }
    
    private func reloadGists(page: UInt64, perPage: UInt64) {
        gists = []
        
        view?.startLoading()
        
        getGistsUseCase.getPublicGists(page: page, perPage: perPage) { result, error in
            guard let gists = result, error == nil else {
                GOExecutor.executeOnMain {
                    self.view?.loadingFailure()
                }
                
                return
            }
            
            self.gists = gists
            
            let gistsViewModels = gists.map {
                GOGistViewModel(gistID: $0.id, name: $0.name, authorLogin: $0.owner.login)
            }
            
            self.page = page
            
            GOExecutor.executeOnMain {
                self.view?.gistsLoaded(gists: gistsViewModels, page: self.page)
                self.mostGists()
            }
        }
    }
    
    private func mostGists() {
        var counter: [String: Int] = [:]
        
        for gist in gists {
            let author = gist.owner.login
            
            counter[author] = (counter[author] ?? 0) + 1
        }
        
        let sorted = counter.sorted { $0.value > $1.value }
        
        var result: [String] = []
        
        for element in sorted where result.count < 10 {
            result.append(element.key)
        }
        
        view?.usersLoaded(users: result)
    }
    
}
