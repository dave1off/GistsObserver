import UIKit

protocol GOGistCommitsTableAdapterInput: class {
    
    var commits: [GOGistCommitViewModel] { get }
    
}

final class GOGistCommitsTableAdapter: NSObject {
    
    private weak var tableView: UITableView?
    private weak var inputProvider: GOGistCommitsTableAdapterInput?
    
    private var commits: [GOGistCommitViewModel] = []
    
    func initialize(tableView: UITableView?, inputProvider: GOGistCommitsTableAdapterInput?) {
        self.tableView = tableView
        self.inputProvider = inputProvider
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.separatorInset = .zero
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.register(
            UINib(nibName: GOGistCommitTableCell.identifier, bundle: nil),
            forCellReuseIdentifier: GOGistCommitTableCell.identifier
        )
    }
    
    func reload() {
        commits = inputProvider?.commits ?? []
        
        tableView?.reloadData()
    }
    
}

extension GOGistCommitsTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GOGistCommitTableCell.height
    }
    
}

extension GOGistCommitsTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GOGistCommitTableCell.identifier
        ) as! GOGistCommitTableCell
        
        let commit = commits[indexPath.row]
        
        cell.authorNameLabel?.text = commit.authorName
        cell.additionsLabel?.text = "\(GOStrings.additions): \(commit.additions.description)"
        cell.deletionsLabel.text = "\(GOStrings.deletions): \(commit.deletions.description)"
        cell.selectionStyle = .none
        
        return cell
    }
    
}
