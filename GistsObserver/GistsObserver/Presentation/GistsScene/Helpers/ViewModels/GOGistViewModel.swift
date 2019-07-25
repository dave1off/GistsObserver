import Foundation

final class GOGistViewModel {

    let gistID: String
    let name: String
    let authorLogin: String
    
    init(gistID: String, name: String, authorLogin: String) {
        self.gistID = gistID
        self.name = name
        self.authorLogin = authorLogin
    }
    
}
