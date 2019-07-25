import Foundation

final class GOGistDescriptionViewModel {
    
    let id: String
    let authorAvatar: Data
    let name: String
    let authorName: String
    let description: String?
    let comments: UInt64
    let files: [GOFileDomainModel]
    
    init(
        id: String,
        authorAvatar: Data,
        name: String,
        authorName: String,
        description: String?,
        comments: UInt64,
        files: [GOFileDomainModel]
    ) {
        self.id = id
        self.authorAvatar = authorAvatar
        self.name = name
        self.authorName = authorName
        self.description = description
        self.comments = comments
        self.files = files
    }
    
}
