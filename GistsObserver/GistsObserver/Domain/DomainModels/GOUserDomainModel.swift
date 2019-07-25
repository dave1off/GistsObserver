import Foundation

final class GOUserDomainModel {

    let login: String
    let id: UInt64
    let avatarURL: String
    
    init(login: String, id: UInt64, avatarURL: String) {
        self.login = login
        self.id = id
        self.avatarURL = avatarURL
    }
    
}
