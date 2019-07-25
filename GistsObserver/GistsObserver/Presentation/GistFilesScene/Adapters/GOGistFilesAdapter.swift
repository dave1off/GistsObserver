import UIKit

protocol GOGistFilesAdapterInput: class {
    
    var files: [GOGistFileViewModel] { get }
    
    func onDownloadFile(name: String, textView: UITextView)
    
}

final class GOGistFilesAdapter: NSObject {
    
    private weak var tableView: UITableView?
    private weak var inputProvider: GOGistFilesAdapterInput?
    
    private var files: [GOGistFileViewModel] = []
    
    func initialize(tableView: UITableView?, inputProvider: GOGistFilesAdapterInput?) {
        self.tableView = tableView
        self.inputProvider = inputProvider
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.separatorInset = .zero
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.register(
            UINib(nibName: GOGistFileTableCell.identifier, bundle: nil),
            forCellReuseIdentifier: GOGistFileTableCell.identifier
        )
    }
    
    func reload() {
        files = inputProvider?.files ?? []
        
        tableView?.reloadData()
    }
    
}

extension GOGistFilesAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GOGistFileTableCell.height
    }
    
}

extension GOGistFilesAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GOGistFileTableCell.identifier
        ) as! GOGistFileTableCell
        
        let file = files[indexPath.row]
        
        cell.nameLabel.text = file.name
        cell.selectionStyle = .none
        
        inputProvider?.onDownloadFile(name: file.name, textView: cell.contentsView)
        
        return cell
    }
    
}
