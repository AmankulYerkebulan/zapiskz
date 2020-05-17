
import Foundation

class FirmDetailModel: Codable {
    var firm: Firm
    let masters:[Master]
    let services:[Service]
    let location: Location
    var schedule = ScheduleModel()
    var showAllServices = false
    
    enum CodingKeys: String,CodingKey {
        case firm,masters,services,location
    }
}

class Firm: Codable {
    let id: Int
    let name: String
    let address: String
    let workStartTime: String
    let workEndTime: String
    let type: String
    let checkRating: Int
    let instagramProfile: String
    let avatarUrl: String
    let phoneNumbers:[String]
    let pictures: [String]
    let todayReservationsCount: Int?
    var averageRating: Float?
    let prepaymentCashbackAmount: String?
}

class Master: Codable {
    let name: String
    let surname: String
    let profession: String
    let serviceIds:[Int]
    let avatarUrl: String
    let rating: Float
}

class Service: Codable {
    let id: Int
    let name: String
    let priceStr: String
    let duration: Int
    var inBasket = false
    enum CodingKeys: String,CodingKey {
        case id,name,priceStr,duration
    }
}

class Location: Codable {
    let markerX: Double
    let markerY: Double
    let centerX: Double
    let centerY: Double
}
