
import Foundation

extension String {
    func removeHtmlTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
extension String {
    func stringToDate(from: String,to: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = from
        let yourDate = formatter.date(from: self)
        formatter.dateFormat = to
        if let _yourDate = yourDate {
            let myStringafd = formatter.string(from: _yourDate)
            return myStringafd
        }
        return ""
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
