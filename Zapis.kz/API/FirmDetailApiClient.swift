import Foundation

struct FirmDetailApiClient: FirmDetailApiProtocol {
    
    func firm(endPoint: MainEndPoint, complition: @escaping (Result<FirmDetailModel, NetworkError>) -> Void) {
        fetch(with: endPoint.request, completion: complition)
    }
}
