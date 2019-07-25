import Foundation

final class GOUserNetworkModel: Codable {

    let login: String
    let id: UInt64
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case login
        case id
        case avatarURL = "avatar_url"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        login = try values.decode(String.self, forKey: .login)
        id = try values.decode(UInt64.self, forKey: .id)
        avatarURL = try values.decode(String.self, forKey: .avatarURL)
    }
    
}

extension GOUserNetworkModel {
    
    static func domainModel(from networkModel: GOUserNetworkModel) -> GOUserDomainModel {
        return GOUserDomainModel(
            login: networkModel.login,
            id: networkModel.id,
            avatarURL: networkModel.avatarURL
        )
    }
    
}
