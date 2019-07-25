import Foundation

final class GOGistCommitViewModel {
    
    let authorName: String
    let additions: UInt64
    let deletions: UInt64
    
    init(authorName: String, additions: UInt64, deletions: UInt64) {
        self.authorName = authorName
        self.additions = additions
        self.deletions = deletions
    }
    
}
