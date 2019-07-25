import Foundation

protocol GOGistFilesPresenterProtocol {
    
    func onViewDidLoad()
    func onDownloadFile()
    
}

class GOGistFilesPresenterImplementation: GOGistFilesPresenterProtocol {
    
    private let files: [GOFileDomainModel]
    
    private let downloadFileUseCase: GODownloadFileUseCaseProtocol
    
    private weak var view: GOGistFilesViewProtocol?
    
    init(
        downloadFileUseCase: GODownloadFileUseCaseProtocol,
        files: [GOFileDomainModel],
        view: GOGistFilesViewProtocol
    ) {
        self.downloadFileUseCase = downloadFileUseCase
        self.files = files
        self.view = view
    }
    
    func onViewDidLoad() {
        let viewModels = files.map { GOGistFileViewModel(name: $0.name) }
        
        view?.filesLoaded(files: viewModels)
    }
    
    func onDownloadFile() {
        let filename = self.view?.filename ?? ""
        let link = files.filter { $0.name == filename }.first?.url ?? ""
        
        downloadFileUseCase.downloadFile(at: link) { data, error in
            guard let textData = data, error == nil else { return }
            
            GOExecutor.executeOnMain {
                self.view?.fileLoaded(name: filename, text: String(data: textData, encoding: .utf8)!)
            }
        }
    }
    
}
