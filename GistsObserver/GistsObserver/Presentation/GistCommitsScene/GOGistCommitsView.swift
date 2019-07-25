import UIKit

protocol GOGistCommitsViewProtocol: class {
    
    func startLoading()
    func commitsLoaded(commits: [GOGistCommitViewModel])
    func loadingFailure()
    
}

class GOGistCommitsViewImplementation: UIViewController {
    
    @IBOutlet weak var commitsTableView: UITableView!
    @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
    
    var presenter: GOGistCommitsPresenterProtocol!
    var router: GOGistCommitsRouterProtocol!
    
    private let adapter = GOGistCommitsTableAdapter()
    
    var commits: [GOGistCommitViewModel] = []
    
    init(configurator: GOGistGommitsConfiguratorProtocol) {
        super.init(nibName: "GOGistCommitsLayout", bundle: nil)
        
        configurator.configure(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter.initialize(tableView: commitsTableView, inputProvider: self)
        
        let backItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-left"), style: .plain, target: self, action: #selector(onBackAction))
        navigationItem.leftBarButtonItem = backItem
        
        presenter.onViewDidLoad()
    }
    
}

extension GOGistCommitsViewImplementation: GOGistCommitsViewProtocol {
    
    func startLoading() {
        loaderIndicator.isHidden = false
        loaderIndicator.startAnimating()
    }
    
    func commitsLoaded(commits: [GOGistCommitViewModel]) {
        loaderIndicator.stopAnimating()
        loaderIndicator.isHidden = true
        
        self.commits = commits
        
        navigationItem.title = GOStrings.commits
        
        adapter.reload()
    }
    
    func loadingFailure() {
        router.goBack()
    }
    
}

extension GOGistCommitsViewImplementation {
    
    @objc private func onBackAction(_ sender: UIBarButtonItem) {
        router.goBack()
    }
    
}

extension GOGistCommitsViewImplementation: GOGistCommitsTableAdapterInput { }
