import Foundation

final class GOImagesRepository {
    
    private let networkService: GONetworkServiceProtocol
    
    private var cache: [String: Data] = [:]
    
    init(networkService: GONetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    private func refreshImages(at paths: [String], callback: @escaping ([String: Data], Error?) -> Void) {
        var result: [String: Data] = [:]
        var counter = 0
        
        for path in paths {
            downloadImage(at: path) { data, error in
                counter += 1
        
                if let imageData = data, error == nil {
                    result[path] = imageData
                }
        
                if counter == paths.count {
                    result.forEach { self.cache[$0] = $1 }
                    callback(result, nil)
                }
            }
        }
    }
    
    
    func fetchImage(at path: String, callback: @escaping (Data?, Error?) -> Void) {
        guard cache[path] == nil else {
            callback(cache[path], nil)
            return
        }
        
        downloadImage(at: path) { data, error in
            guard let imageData = data, error == nil else {
                callback(data, error)
                return
            }
            
            self.cache[path] = imageData
            
            callback(imageData, nil)
        }
    }
    
}

extension GOImagesRepository: GODownloadImageRepositoryProtocol {
    
    func downloadImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        networkService.get(endpoint: path, callback: callback)
    }
    
}

extension GOImagesRepository: GOAddImagesRepositoryProtocol {
    
    func addImages(at paths: [String], callback: @escaping ([String: Data], Error?) -> ()) {
        refreshImages(at: paths, callback: callback)
    }
    
    func addImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        refreshImages(at: [path]) { result, error in
            callback(result.first?.value, nil)
        }
    }
    
}

extension GOImagesRepository {
    
    func updateImages(callback: @escaping ([String: Data], Error?) -> ()) {
        refreshImages(at: cache.keys.map { $0 }, callback: callback)
    }
    
    func updateImage(at path: String, callback: @escaping (Data?, Error?) -> ()) {
        refreshImages(at: [path]) { result, error in
            callback(result.first?.value, error)
        }
    }
    
}

extension GOImagesRepository {
    
    func getImages(at paths: [String], callback: @escaping ([String: Data]?, Error?) -> ()) {
        var result: [String: Data] = [:]
        
        for path in paths {
            guard let data = cache[path] else { continue }
            
            result[path] = data
        }
        
        callback(result, nil)
    }
    
}
