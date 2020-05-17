
import Foundation
import UIKit

class HomeModel: Codable {
    
    let recommendedFirms   :[FirmModel]
    let popularFirms       :[FirmModel]
    let recentlyAddedFirms :[FirmModel]
    let masters            :[FirmModel]
}

struct FirmModel: Codable {
    
    let id: Int
    let type: String
    let name: String
    let address: String
    let checkRating: Int
    let avatar: String
    let workSchedule: String
    let picture: String
    let averageRating: Float
    let cashback: String?
    let todayReservationsCount: Int?
    
    enum CodingKeys: String,CodingKey {
        case id,name,address,checkRating,workSchedule,averageRating,todayReservationsCount,type
        case avatar = "avatarUrl"
        case picture = "pictureUrl"
        case cashback = "prepaymentCashbackAmount"
    }
}
