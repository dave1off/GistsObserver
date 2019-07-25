import Foundation

class GOGistDomainModel {

    let id: String
    let files: [String: GOFileDomainModel]
    let createdAt: Date
    let updatedAt: Date
    let description: String?
    let comments: UInt64
    let owner: GOUserDomainModel
    let name: String
    
    init(
        id: String,
        files: [String: GOFileDomainModel],
        createdAt: Date,
        updatedAt: Date,
        description: String?,
        comments: UInt64,
        owner: GOUserDomainModel,
        name: String
    ) {
        self.id = id
        self.files = files
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.description = description
        self.comments = comments
        self.owner = owner
        self.name = name
    }
    
}
