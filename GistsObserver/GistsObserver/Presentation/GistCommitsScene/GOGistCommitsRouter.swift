protocol GOGistCommitsRouterProtocol {
    
    func goBack()
    
}

class GOGistCommitsRouterImplementation: GOGistCommitsRouterProtocol {
    
    private weak var view: GOGistCommitsViewImplementation?
    
    init(view: GOGistCommitsViewImplementation) {
        self.view = view
    }
    
    func goBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
