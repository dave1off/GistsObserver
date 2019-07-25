import UIKit

protocol GOGistsViewProtocol: class {
    
    func gistsLoaded(gists: [GOGistViewModel], page: UInt64)
    func imageLoadedFor(data: Data, user: String)
    
    var userForAvatar: String { get }
    
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
    
    var presenter: GOGistsPresenterProtocol!
    var router: GOGistsRouterProtocol!
    
    var gists: [GOGistViewModel] = []
    var images: [String: [UIImageView]] = [:]
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
        usersCollectionView.backgroundColor = GOColors.goGray
        
        gistsAdapter.initialize(tableView: gistsTableView, inputProvider: self)
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

}

extension GOGistsViewImplementation: GOGistsViewProtocol {
    
    func gistsLoaded(gists: [GOGistViewModel], page: UInt64) {
        self.gists = gists
        
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        gistsTableView.isHidden = false
        navigationTitleLabel.text = page.description
        
        if page > 1 {
            navigationLeftArrow.isEnabled = true
        }
        
        navigationRightArrow.isEnabled = true
        
        gistsAdapter.reload()
        
        gistsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func imageLoadedFor(data: Data, user: String) {
        images[user]?.forEach { $0.image = UIImage(data: data) }
    }
    
    func startLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
        
        navigationLeftArrow.isEnabled = false
        navigationRightArrow.isEnabled = false
        
        gistsTableView.isHidden = true
    }
    
    func loadingFailure() {
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        
        gistsTableView.isHidden = false
        
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
    
    func onDownloadImage(for avatarView: UIImageView, author: String) {
        if images[author] == nil {
            images[author] = []
        }
        
        images[author]?.append(avatarView)
        
        userForAvatar = author
        presenter.onDownloadImage()
    }
    
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
