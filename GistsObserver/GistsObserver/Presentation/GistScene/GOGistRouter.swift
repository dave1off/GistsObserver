protocol GOGistRouterProtocol {
    
    func goBack()
    func setGistCommitsScene(view: GOGistCommitsViewImplementation)
    
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
    
}
