import UIKit

protocol GOBackRouterProtocol {
    
    func goBack()
    
}

class GOBackRouterImplementation: GOBackRouterProtocol {
    
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func goBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
