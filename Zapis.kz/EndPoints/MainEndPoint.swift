
enum MainEndPoint: Endpoint {
    
    case firms
    case firm(id: Int)

    var path: String {
        switch self {
        case .firms:
            return Global.pathFor(key: "home")
        case .firm(let id):
            return Global.pathFor(key: "firm") + String(id)
        }
    }
    
    var parameters: RequestParameters? {
        return nil
    }
    
    var body: BodyParameters? {
        return nil
    }
    
    var method: HTTPMethod {
        return .get
    }
}
