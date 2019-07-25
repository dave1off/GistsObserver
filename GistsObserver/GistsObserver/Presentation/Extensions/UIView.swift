import UIKit

extension UIView {
    
    func makeRound() {
        layer.cornerRadius = bounds.width / 2
    }
    
    static var identifier: String {
        var metadata = description().split(separator: ".")
        metadata.remove(at: 0)
        
        return metadata.map { String($0) }.joined()
    }
    
}
