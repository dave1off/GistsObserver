import Foundation

final class GOCommitDomainModel {
    
    let user: GOUserDomainModel
    let version: String
    let date: Date
    let changes: GOGistChangesDomainModel
    
    init(user: GOUserDomainModel, version: String, date: Date, changes: GOGistChangesDomainModel) {
        self.user = user
        self.version = version
        self.date = date
        self.changes = changes
    }

}
