import UIKit

protocol GOGistsViewProtocol: class {
    
    var userForAvatar: String { get }
    
    func gistsLoaded(gists: [GOGistViewModel], page: UInt64)
    func usersLoaded(users: [String])
    
    func imageLoadedFor(data: Data, user: String)
    
    func startLoading()
    func loadingFailure()
    
}

class GOGistsViewImplementation: UIViewController {
    
    @IBOutlet weak var usersCollectionView: UICollectionView!
    @IBOutlet weak var gistsTableView: UITableView!
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var navigationLeftArrow: UIButton!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var navigationRightArrow: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    private let gistsAdapter = GOGistsTableAdapter()
    private let usersAdapter = GOUsersCollectionAdapter()
    
    var presenter: GOGistsPresenterProtocol!
    var router: GOGistsRouterProtocol!
    
    var gists: [GOGistViewModel] = []
    var users: [String] = []
    
    var userForAvatar = ""
    
    init(configurator: GOGistsConfiguratorProtocol) {
        super.init(nibName: "GOGistsController", bundle: nil)
        
        configurator.configure(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.backgroundColor = GOColors.goGray
        
        gistsAdapter.initialize(tableView: gistsTableView, inputProvider: self)
        usersAdapter.initialize(tableView: usersCollectionView, inputProvider: self)
        
        presenter.onViewDidLoad()
        
        navigationItem.title = GOStrings.gists
        
        let refreshItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(onGistsReload)
        )
        
        navigationItem.rightBarButtonItem = refreshItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedRows = gistsTableView.indexPathsForSelectedRows ?? []
        
        for indexPath in selectedRows {
            gistsTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func onDownloadImage(author: String) {
        userForAvatar = author
        
        presenter.onDownloadImage()
    }

}

extension GOGistsViewImplementation: GOGistsViewProtocol {
    
    func usersLoaded(users: [String]) {
        self.users = users
        
        usersAdapter.reload()
        usersCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
    }
    
    func gistsLoaded(gists: [GOGistViewModel], page: UInt64) {
        self.gists = gists
        
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        gistsTableView.isHidden = false
        usersCollectionView.isHidden = false
        
        navigationTitleLabel.text = page.description
        
        if page > 1 {
            navigationLeftArrow.isEnabled = true
        }
        
        navigationRightArrow.isEnabled = true
        
        gistsAdapter.reload()
        gistsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func imageLoadedFor(data: Data, user: String) {
        let image = UIImage(data: data) ?? UIImage()
        
        gistsAdapter.setImage(image, for: user)
        usersAdapter.setImage(image, for: user)
    }
    
    func startLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        navigationLeftArrow.isEnabled = false
        navigationRightArrow.isEnabled = false
        
        gistsTableView.isHidden = true
        usersCollectionView.isHidden = true
    }
    
    func loadingFailure() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        gistsTableView.isHidden = false
        usersCollectionView.isHidden = false
        
        navigationLeftArrow.isEnabled = true
        navigationRightArrow.isEnabled = true
    }
    
}

extension GOGistsViewImplementation: GOGistsTableAdapterInput {
    
    func onSelect(gist: GOGistViewModel) {
        let gistConfigurator = GOGistConfiguratorImplementation(id: gist.gistID)
        let gistView = GOGistViewImplementation(configurator: gistConfigurator)
        
        router.setGistScene(view: gistView)
    }
    
}

extension GOGistsViewImplementation: GOUsersCollectionAdapterInput {
    
    
    
}

extension GOGistsViewImplementation {
    
    @IBAction func onPrevPage(_ sender: UIButton) {
        presenter.onPrevPage()
    }
    
    @IBAction func onNextPage(_ sender: UIButton) {
        presenter.onNextPage()
    }
    
    @objc private func onGistsReload(_ sender: UIBarButtonItem) {
        presenter.onCurrentPage()
    }
    
}
