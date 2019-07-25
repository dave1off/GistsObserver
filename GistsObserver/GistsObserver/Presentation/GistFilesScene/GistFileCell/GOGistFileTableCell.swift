import UIKit

class GOGistFileTableCell: UITableViewCell {
    
    static let height: CGFloat = 200
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentsView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentsView.isEditable = false
    }
    
}
