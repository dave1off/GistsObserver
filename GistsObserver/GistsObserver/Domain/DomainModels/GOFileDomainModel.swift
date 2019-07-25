import Foundation

final class GOFileDomainModel {

    let name: String
    let type: String
    let language: String?
    let size: UInt64
    let url: String
    let content: String?
    
    init(name: String, type: String, language: String?, size: UInt64, url: String, content: String?) {
        self.name = name
        self.type = type
        self.language = language
        self.size = size
        self.url = url
        self.content = content
    }
    
}
