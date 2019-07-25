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
    
    private var images: [String: Data] = [:]
    private var gists: [GOGistDomainModel] = []
    
    private var page: UInt64 = 1
    private let perPage: UInt64 = 10

    private weak var view: GOGistsViewProtocol?
    
    init(
        getGistsUseCase: GOGetPublicGistsUseCaseProtocol,
        downloadImageUseCase: GODownloadImageUseCaseProtocol,
        view: GOGistsViewProtocol
    ) {
        self.getGistsUseCase = getGistsUseCase
        self.downloadImageUseCase = downloadImageUseCase
        
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
        
        if let alreadyDonwloaded = images[login] {
            view?.imageLoadedFor(data: alreadyDonwloaded, user: login)
            return
        }
        
        let link = gists.filter { $0.owner.login == login }.first?.owner.avatarURL ?? ""
        
        downloadImageUseCase.downloadImage(at: link) { data, error in
            guard let imageData = data, error == nil else { return }
            
            self.images[login] = imageData
            
            self.executeOnMain {
                self.view?.imageLoadedFor(data: imageData, user: login)
            }
        }
    }
    
    private func reloadGists(page: UInt64, perPage: UInt64) {
        gists = []
        
        view?.startLoading()
        
        getGistsUseCase.getPublicGists(page: page, perPage: perPage) { result, error in
            guard let gists = result, error == nil else {
                self.executeOnMain {
                    self.view?.loadingFailure()
                }
                
                return
            }
            
            self.gists = gists
            
            let gistsViewModels = gists.map {
                GOGistViewModel(gistID: $0.id, name: $0.name, authorLogin: $0.owner.login)
            }
            
            self.page = page
            
            self.executeOnMain {
                self.view?.gistsLoaded(gists: gistsViewModels, page: self.page)
                self.mostGists()
            }
        }
    }
    
    private func executeOnMain(block: @escaping () -> ()) {
        DispatchQueue.main.async(execute: block)
    }
    
    private func mostGists() {
        var counter: [String: Int] = [:]
        
        for gist in gists {
            let author = gist.owner.login
            
            counter[author] = (counter[author] ?? 0) + 1
        }
    }
    
}
