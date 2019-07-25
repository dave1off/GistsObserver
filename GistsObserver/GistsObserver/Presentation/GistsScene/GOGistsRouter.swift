protocol GOGistsRouterProtocol {
    
    func setGistScene(view: GOGistViewImplementation)
    
}

class GOGistsRouterImplementation: GOGistsRouterProtocol {
    
    private weak var view: GOGistsViewImplementation?
    
    init(view: GOGistsViewImplementation) {
        self.view = view
    }
    
    func setGistScene(view: GOGistViewImplementation) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
    
}
