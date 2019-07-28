import Foundation

protocol GOAddImagesToRepositoryUseCaseProtocol {
    
    func addImages(at paths: [String], callback: @escaping ([String: Data], Error?) -> ())
    
}

class GOAddImagesToRepositoryUseCaseImplementation: GOAddImagesToRepositoryUseCaseProtocol {
    
    private let repository: GOAddImagesRepositoryProtocol
    
    init(repository: GOAddImagesRepositoryProtocol) {
        self.repository = repository
    }
    
    func addImages(at paths: [String], callback: @escaping ([String: Data], Error?) -> ()) {
        repository.addImages(at: paths, callback: callback)
    }
    
}
