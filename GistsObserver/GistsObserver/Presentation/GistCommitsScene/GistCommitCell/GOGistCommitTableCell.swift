import UIKit

class GOGistCommitTableCell: UITableViewCell {
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var additionsLabel: UILabel!
    @IBOutlet weak var deletionsLabel: UILabel!
    
    static let height: CGFloat = 100

    override func awakeFromNib() {
        super.awakeFromNib()
        
        additionsLabel.textColor = GOColors.goGreen
        deletionsLabel.textColor = GOColors.goRed
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        authorNameLabel.text = ""
        additionsLabel.text = ""
        deletionsLabel.text = ""
    }
    
}
