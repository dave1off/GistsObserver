import Foundation

protocol GOAddImagesRepositoryProtocol {
    
    func addImages(at paths: [String], callback: @escaping ([String: Data], Error?) -> ())
    
}
