import Foundation

final class GOGistFileNetworkModel: Codable {
    
    let name: String
    let type: String
    let language: String?
    let size: UInt64
    let url: String
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "filename"
        case type
        case language
        case size
        case url = "raw_url"
        case content
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        size = try values.decode(UInt64.self, forKey: .size)
        url = try values.decode(String.self, forKey: .url)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
    
}
