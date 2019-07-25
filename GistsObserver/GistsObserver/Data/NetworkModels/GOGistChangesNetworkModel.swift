import Foundation

final class GOGistChangesNetworkModel: Codable {

    let total: UInt64
    let additions: UInt64
    let deletions: UInt64
    
}

extension GOGistChangesNetworkModel {
    
    static func domainModel(from networkModel: GOGistChangesNetworkModel) -> GOGistChangesDomainModel {
        return GOGistChangesDomainModel(
            total: networkModel.total,
            additions: networkModel.additions,
            deletions: networkModel.deletions
        )
    }
    
}
