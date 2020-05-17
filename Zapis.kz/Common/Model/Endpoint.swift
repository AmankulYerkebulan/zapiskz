
import Foundation

struct API {
    static let baseURL = "?"
    static let gatewayURL = "?"
    static let devURL = "?"
}

protocol Endpoint {
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: RequestParameters? { get }
    var body: BodyParameters? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    
    var request: URLRequest {
        let url = URL(string: self.path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let body = body {
            urlRequest.httpBody = body.percentEscaped().data(using: .utf8)
        }
        
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    var description: String {
        return """
        \n
        -------------- ENDPOINT --------------
        PATH: \(path)
        HEADERS: \(headers)
        PARAMETERS: \(parameters.debugDescription)
        BODY: \(body.debugDescription)
        METHOD: \(method)
        --------------------------------------
        """
    }
}

extension Endpoint {
        
    var headers: HTTPHeaders {
        return defaultHeaders
    }
    
    var defaultHeaders: HTTPHeaders {
        var defaultHeaders:[String:String] = [:]
        
        let shouldSendSenderType = UserDefaults.standard.bool(forKey: "shouldSendSenderType")
        let shouldSendImageData = UserDefaults.standard.bool(forKey: "shouldSendImageData")
        if shouldSendSenderType {
            defaultHeaders["X-Email-Sender-Type"] = "1"
        } else if shouldSendImageData {
            defaultHeaders["Content-Type"] = "image/jpeg"
        } else {
            defaultHeaders.removeValue(forKey: "X-Email-Sender-Type")
            defaultHeaders["Content-Type"] = "application/x-www-form-urlencoded"
        }
        
        return defaultHeaders
    }
    
    var authHeaders: HTTPHeaders {
        let authHeaders = self.defaultHeaders
        return authHeaders
    }
}

