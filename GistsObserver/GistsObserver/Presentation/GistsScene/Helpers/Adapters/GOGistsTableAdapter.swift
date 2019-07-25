import UIKit

protocol GOGistsTableAdapterInput: class {
    
    var gists: [GOGistViewModel] { get set }
    
    func onDownloadImage(for avatarView: UIImageView, author: String)
    func onSelect(gist: GOGistViewModel)
    
}

final class GOGistsTableAdapter: NSObject {
    
    private weak var tableView: UITableView?
    private weak var inputProvider: GOGistsTableAdapterInput?
    
    private var gists: [GOGistViewModel] = []
    
    func initialize(tableView: UITableView?, inputProvider: GOGistsTableAdapterInput?) {
        self.tableView = tableView
        self.inputProvider = inputProvider
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.separatorInset = .zero
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.register(
            UINib(nibName: GOGistTableCell.identifier, bundle: nil),
            forCellReuseIdentifier: GOGistTableCell.identifier
        )
    }
    
    func reload() {
        gists = inputProvider?.gists ?? []
        
        tableView?.reloadData()
    }

}

extension GOGistsTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GOGistTableCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputProvider?.onSelect(gist: gists[indexPath.row])
    }
    
}

extension GOGistsTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GOGistTableCell.identifier) as! GOGistTableCell
        let gist = gists[indexPath.row]
        
        cell.gistNameLabel.text = gist.name
        cell.authorLoginLabel.text = gist.authorLogin
        cell.authorAvatarView.image = nil
        
        inputProvider?.onDownloadImage(for: cell.authorAvatarView, author: gist.authorLogin)
        
        return cell
    }
    
}
