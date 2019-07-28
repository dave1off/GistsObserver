import UIKit

class GOUserCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarView.image = nil
        nameLabel.text = ""
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.makeRound()
    }

}
