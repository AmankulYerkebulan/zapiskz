
import Foundation

enum ErrorCode: Int {
    case unauthorized = 401
    case invalidRefreshToken = 8
    case phoneAuthError = 215
    static var `default` = -1
}

enum ErrorType {
    case requestFailed
    case jsonConversionFailure(error: String)
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case gatewayError(error: String)
    case customError(error: String)
}

struct NetworkError: Error {
    
    var errorType: ErrorType?
    var statusCode: ErrorCode?
    var data: [String: Any]?
    
    init(_ errorType: ErrorType, statusCode: Int = -1, data: [String: Any]? = nil) {
        self.errorType = errorType
        self.statusCode = ErrorCode(rawValue: statusCode)
        self.data = data
    }
    
    var localizedDescription: String {
        switch self.errorType {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure(let error): return error
        case .gatewayError(let error): return error
        case .customError(let error): return error
        case .none: return "Error"
        }
    }
    
}
