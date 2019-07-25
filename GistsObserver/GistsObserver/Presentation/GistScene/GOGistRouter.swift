protocol GOGistRouterProtocol {
    
    func goBack()
    
    func setGistCommitsScene(view: GOGistCommitsViewImplementation)
    func setGistFilesScene(view: GOGistFilesViewImplementation)
    
}

class GOGistRouterImplementation: GOGistRouterProtocol {
    
    private weak var view: GOGistViewImplementation?
    
    init(view: GOGistViewImplementation) {
        self.view = view
    }
    
    func goBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func setGistCommitsScene(view: GOGistCommitsViewImplementation) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
    func setGistFilesScene(view: GOGistFilesViewImplementation) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
}
