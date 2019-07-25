import Foundation

final class GOGetGistsRequestModel: Decodable {

    let id: String
    let files: [String: GOGistFileNetworkModel]
    let createdAt: String
    let updatedAt: String
    let description: String?
    let comments: UInt64
    let owner: GOUserNetworkModel
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case files
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case description
        case comments
        case owner
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        files = try values.decode([String: GOGistFileNetworkModel].self, forKey: .files)
        createdAt = try values.decode(String.self, forKey: .createdAt)
        updatedAt = try values.decode(String.self, forKey: .updatedAt)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        comments = try values.decode(UInt64.self, forKey: .comments)
        owner = try values.decode(GOUserNetworkModel.self, forKey: .owner)
    }
    
    static func domainModel(from requestModel: GOGetGistsRequestModel) -> GOGistDomainModel {
        let domainFiles = requestModel.files.mapValues {
            GOFileDomainModel(name: $0.name, type: $0.type, language: $0.language, size: $0.size, url: $0.url, content: $0.content)
        }
        
        let requestOwner = requestModel.owner
        
        let domainOwner = GOUserDomainModel(
            login: requestOwner.login,
            id: requestOwner.id,
            avatarURL: requestOwner.avatarURL
        )
        
        let createdAt = requestModel.createdAt.gitHubDate
        let updatedAt = requestModel.updatedAt.gitHubDate
        
        return GOGistDomainModel(
            id: requestModel.id,
            files: domainFiles,
            createdAt: createdAt,
            updatedAt: updatedAt,
            description: requestModel.description,
            comments: requestModel.comments,
            owner: domainOwner,
            name: requestModel.files.first?.value.name ?? ""
        )
    }
    
}
