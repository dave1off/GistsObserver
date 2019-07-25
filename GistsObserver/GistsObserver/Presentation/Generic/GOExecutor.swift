import Foundation

final class GOExecutor {
    
    static func executeOnMain(block: @escaping () -> ()) {
        DispatchQueue.main.async(execute: block)
    }

}
