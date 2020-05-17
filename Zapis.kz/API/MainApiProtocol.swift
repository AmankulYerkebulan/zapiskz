

protocol MainApiProtocol: APIClient {
    
    typealias MainCompleteHandler = (Result<HomeModel,NetworkError>) -> Void
        
    func firms(endPoint: MainEndPoint, complition: @escaping MainApiProtocol.MainCompleteHandler)
}
