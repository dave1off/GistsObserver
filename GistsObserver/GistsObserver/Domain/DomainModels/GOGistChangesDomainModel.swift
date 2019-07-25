import Foundation

final class GOGistChangesDomainModel {

    let total: UInt64
    let additions: UInt64
    let deletions: UInt64
    
    init(total: UInt64, additions: UInt64, deletions: UInt64) {
        self.total = total
        self.additions = additions
        self.deletions = deletions
    }
    
}
