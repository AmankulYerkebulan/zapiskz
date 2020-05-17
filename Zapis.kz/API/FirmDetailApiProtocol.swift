

protocol FirmDetailApiProtocol: APIClient {
    
    typealias DetailCompleteHandler = (Result<FirmDetailModel,NetworkError>) -> Void
        
    func firm(endPoint: MainEndPoint, complition: @escaping FirmDetailApiProtocol.DetailCompleteHandler)
}
