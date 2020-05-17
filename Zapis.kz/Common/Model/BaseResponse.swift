
import Foundation

struct BaseResponse<T: Codable>: Codable {
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case data
    }

}
