import Foundation

final class GOGistNetworkModel: Decodable {
    
    let id: String
    let files: [String: GOGistFileNetworkModel]
    let createdAt: String
    let updatedAt: String
    let description: String
    let comments: Int
    let owner: GOUserNetworkModel
    //let forks: [GOGistForkNetworkModel]
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case files
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case comments
        case owner
        case forks = "forsk"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        files = try values.decode([String: GOGistFileNetworkModel].self, forKey: .files)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
        description = try values.decode(String.self, forKey: .description)
        comments = try values.decode(Int.self, forKey: .comments)
        owner = try values.decode(GOUserNetworkModel.self, forKey: .owner)
        //forks = try values.decode([GOGistForkNetworkModel].self, forKey: .forks)
    }
    
}
