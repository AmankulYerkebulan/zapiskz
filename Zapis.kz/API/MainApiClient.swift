import Foundation

struct MainAPIClient: MainApiProtocol {
    
    func firms(endPoint: MainEndPoint, complition: @escaping (Result<HomeModel, NetworkError>) -> Void) {
        fetch(with: endPoint.request, completion: complition)
    }
}
