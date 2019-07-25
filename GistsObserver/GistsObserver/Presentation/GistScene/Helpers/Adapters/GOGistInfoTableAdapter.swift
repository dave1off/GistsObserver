import UIKit

protocol GOGistInfoTableAdapterInput: class {
    
    var infos: [GOGistInfoViewModel] { get }
    
    func onSelect(info: Int)
    
}

final class GOGistInfoTableAdapter: NSObject {
    
    private weak var tableView: UITableView?
    private weak var inputProvider: GOGistInfoTableAdapterInput?
    
    private var infos: [GOGistInfoViewModel] = []
    
    func initialize(tableView: UITableView?, inputProvider: GOGistInfoTableAdapterInput?) {
        self.tableView = tableView
        self.inputProvider = inputProvider
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        self.tableView?.isScrollEnabled = false
        
        self.tableView?.separatorInset = .zero
        self.tableView?.tableFooterView = UIView()
        
        self.tableView?.register(GOGistInfoTableCell.self, forCellReuseIdentifier: GOGistInfoTableCell.identifier)
    }
    
    func reload() {
        infos = inputProvider?.infos ?? []
        
        tableView?.reloadData()
    }
    
}

extension GOGistInfoTableAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        inputProvider?.onSelect(info: indexPath.row)
    }
    
}

extension GOGistInfoTableAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: GOGistInfoTableCell.identifier
        ) as! GOGistInfoTableCell
        
        let info = infos[indexPath.row]
        
        cell.textLabel?.text = info.name
        cell.detailTextLabel?.text = info.counter?.description
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
}

