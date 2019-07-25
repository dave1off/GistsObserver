import Foundation

extension String {
    
    var gitHubDate: Date {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter.date(from: self) ?? Date()
    }
    
}
