import UIKit

protocol GOGistFilesViewProtocol: class {
    
    var filename: String { get }
    
    func filesLoaded(files: [GOGistFileViewModel])
    func fileLoaded(name: String, text: String)
    
}

class GOGistFilesViewImplementation: UIViewController {
    
    @IBOutlet weak var commitsTableView: UITableView!
    
    var presenter: GOGistFilesPresenterProtocol!
    var router: GOBackRouterProtocol!
    
    private let adapter = GOGistFilesAdapter()
    
    var files: [GOGistFileViewModel] = []
    var contents: [String: UITextView] = [:]
    
    var filename = ""
    
    init(configurator: GOGistFilesConfiguratorProtocol) {
        super.init(nibName: "GOGistFilesLayout", bundle: nil)
        
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

extension GOGistFilesViewImplementation: GOGistFilesViewProtocol {
    
    func filesLoaded(files: [GOGistFileViewModel]) {
        self.files = files
        
        navigationItem.title = GOStrings.files
        
        adapter.reload()
    }
    
    func fileLoaded(name: String, text: String) {
        contents[name]?.text = text
    }
    
}

extension GOGistFilesViewImplementation {
    
    @objc private func onBackAction(_ sender: UIBarButtonItem) {
        router.goBack()
    }
    
}

extension GOGistFilesViewImplementation: GOGistFilesAdapterInput {
    
    func onDownloadFile(name: String, textView: UITextView) {
        contents[name] = textView
        
        filename = name
        
        presenter.onDownloadFile()
    }
    
}
