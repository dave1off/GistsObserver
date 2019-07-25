import Foundation

protocol GODownloadImageRepositoryProtocol {
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ())
    
}
