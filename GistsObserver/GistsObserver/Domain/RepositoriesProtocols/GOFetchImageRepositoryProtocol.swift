import Foundation

protocol GOFetchImageRepositoryProtocol {
    
    func fetchImage(at path: String, callback: @escaping (Data?, Error?) -> Void)
    
}
