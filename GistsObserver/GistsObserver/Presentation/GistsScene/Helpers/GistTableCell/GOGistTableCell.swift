import UIKit

class GOGistTableCell: UITableViewCell {
    
    @IBOutlet weak var authorAvatarView: UIImageView!
    @IBOutlet weak var gistNameLabel: UILabel!
    @IBOutlet weak var authorLoginLabel: UILabel!
    
    static let height: CGFloat = 70

    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorAvatarView.makeRound()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gistNameLabel.text = ""
        authorLoginLabel.text = ""
        authorAvatarView.image = nil
    }
    
}
