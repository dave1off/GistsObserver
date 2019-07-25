import UIKit

protocol GOGistViewProtocol: class {
    
    func starLoading()
    func infoLoaded(gist: GOGistDescriptionViewModel)
    func loadingFailure()
    
}

class GOGistViewImplementation: UIViewController {
    
    @IBOutlet weak var authorAvatarView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var gistDescription: UILabel!
    @IBOutlet weak var commentsHintLabel: UILabel!
    @IBOutlet weak var commentsCounterLabel: UILabel!
    @IBOutlet weak var gistInfosTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let gistsAdapter = GOGistInfoTableAdapter()
    
    var presenter: GOGistPresenterProtocol!
    var router: GOGistRouterProtocol!
    
    var infos: [GOGistInfoViewModel] = []
    
    private var gistID = ""
    
    init(configurator: GOGistConfiguratorProtocol) {
        super.init(nibName: "GOGistLayout", bundle: nil)
        
        configurator.configure(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gistsAdapter.initialize(tableView: gistInfosTableView, inputProvider: self)

        authorAvatarView.makeRound()
        
        let backItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-left"), style: .plain, target: self, action: #selector(onBackAction))
        navigationItem.leftBarButtonItem = backItem
        
        presenter.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedRows = gistInfosTableView.indexPathsForSelectedRows ?? []
        
        for indexPath in selectedRows {
            gistInfosTableView.deselectRow(at: indexPath, animated: true)
        }
    }

}

extension GOGistViewImplementation: GOGistViewProtocol {
    
    func starLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        authorAvatarView.isHidden = true
        
        authorNameLabel.isHidden = true
        gistDescription.isHidden = true
        commentsCounterLabel.isHidden = true
        commentsHintLabel.isHidden = true
        
        gistInfosTableView.isHidden = true
    }
    
    func infoLoaded(gist: GOGistDescriptionViewModel) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        authorAvatarView.isHidden = false
        authorAvatarView.image = UIImage(data: gist.authorAvatar)
        
        authorNameLabel.isHidden = false
        authorNameLabel.text = gist.authorName
        
        gistDescription.isHidden = false
        gistDescription.text = gist.description
        
        commentsCounterLabel.isHidden = false
        commentsCounterLabel.text = gist.comments.description
        
        commentsHintLabel.isHidden = false
        commentsHintLabel.text = GOStrings.comments
        
        infos = [
            GOGistInfoViewModel(name: GOStrings.files, counter: gist.files.count),
            GOGistInfoViewModel(name: GOStrings.commits, counter: nil)
        ]
        
        gistInfosTableView.isHidden = false
        gistsAdapter.reload()
        
        gistID = gist.id
        
        navigationItem.title = gist.name
    }
    
    func loadingFailure() {
        router.goBack()
    }
    
}

extension GOGistViewImplementation: GOGistInfoTableAdapterInput {
    
    func onSelect(info: Int) {
        let viewModel = infos[info]
        
        if viewModel.name == GOStrings.files {
            
        } else {
            let gistCommitsConfigurator = GOGistGommitsConfiguratorImplementation(id: gistID)
            let gistCommitsView = GOGistCommitsViewImplementation(configurator: gistCommitsConfigurator)
            router.setGistCommitsScene(view: gistCommitsView)
        }
    }
    
}

extension GOGistViewImplementation {
    
    @objc private func onBackAction(_ sender: UIBarButtonItem) {
        router.goBack()
    }
    
}
