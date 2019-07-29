import UIKit

protocol GOUsersCollectionAdapterInput: class {
    
    var users: [String] { get }
    
    func onDownloadImage(author: String)
    
}

final class GOUsersCollectionAdapter: NSObject {
    
    private weak var collectionView: UICollectionView?
    private weak var inputProvider: GOUsersCollectionAdapterInput?
    
    private var users: [String] = []
    
    func initialize(tableView: UICollectionView?, inputProvider: GOUsersCollectionAdapterInput?) {
        self.collectionView = tableView
        self.inputProvider = inputProvider
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        self.collectionView?.isPrefetchingEnabled = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        self.collectionView?.register(
            UINib(nibName: GOUserCollectionCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: GOUserCollectionCell.identifier
        )
    }
    
    func reload() {
        users = inputProvider?.users ?? []
        
        collectionView?.reloadData()
    }
    
    func setImage(_ image: UIImage, for user: String) {
        for (order, name) in users.enumerated() where name == user {
            let indexPath = IndexPath(row: order, section: 0)
            
            guard let cell = collectionView?.cellForItem(at: indexPath) as? GOUserCollectionCell else { continue }
            
            cell.avatarView.image = image
        }
    }
    
}

extension GOUsersCollectionAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GOUserCollectionCell.identifier, for: indexPath
        ) as? GOUserCollectionCell else { return UICollectionViewCell() }
        
        cell.nameLabel.text = users[indexPath.row]
        
        inputProvider?.onDownloadImage(author: users[indexPath.row])
        
        return cell
    }
    
}

extension GOUsersCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 65, height: 65)
    }
    
}
