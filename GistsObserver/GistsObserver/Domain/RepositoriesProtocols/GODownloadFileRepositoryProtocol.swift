import Foundation

protocol GODownloadFileRepositoryProtocol {
    
    func downloadFile(at path: String, callback: @escaping (Data?, Error?) -> ())
    
}
