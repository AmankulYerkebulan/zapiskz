
import Foundation

public typealias RequestParameters = [String: String]
public typealias BodyParameters = [String: Any]

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
}

public typealias HTTPHeaders = [String: String]
