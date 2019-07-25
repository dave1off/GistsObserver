import Foundation

final class GOGistCommitNetworkModel: Codable {

    let user: GOUserNetworkModel
    let version: String
    let date: String
    let changes: GOGistChangesNetworkModel
    
    enum CodingKeys: String, CodingKey {
        
        case user
        case version
        case date = "committed_at"
        case changes = "change_status"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        user = try values.decode(GOUserNetworkModel.self, forKey: .user)
        version = try values.decode(String.self, forKey: .version)
        date = try values.decode(String.self, forKey: .date)
        changes = try values.decode(GOGistChangesNetworkModel.self, forKey: .changes)
    }
    
}

extension GOGistCommitNetworkModel {
    
    static func domainModel(from networkModel: GOGistCommitNetworkModel) -> GOCommitDomainModel {
        let domainUser = GOUserNetworkModel.domainModel(from: networkModel.user)
        let domainChanges = GOGistChangesNetworkModel.domainModel(from: networkModel.changes)
        
        return GOCommitDomainModel(
            user: domainUser,
            version: networkModel.version,
            date: networkModel.date.gitHubDate,
            changes: domainChanges
        )
    }
    
}
