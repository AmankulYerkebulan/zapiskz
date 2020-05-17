
import Foundation

protocol APIClient {
    func fetch<T: Codable>(with request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void)
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Codable?, NetworkError?) -> Void
    
    private func decodingTask<T: Codable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) {
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError(.requestFailed))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(nil, NetworkError(.responseUnsuccessful))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError(.invalidData))
                return
            }
            
            self.serializeResponse(from: data, with: decodingType, and: completion, request: request)
        }.resume()
    }
    
    func fetch<T: Codable>(with request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        print("URL Request description: \(request.description)")
        decodingTask(with: request, decodingType: T.self) { (json , error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        Alert.shared.show(title: "", message: error.localizedDescription ) {
                            completion(Result.failure(error))
                        }
                    } else {
                        Alert.shared.show(title: "", message: NetworkError(.invalidData).localizedDescription) {
                            completion(Result.failure(NetworkError(.invalidData)))
                        }
                    }
                    return
                }
                
                if let value = json as? T {
                    completion(.success(value))
                } else {
                    Alert.shared.show(title: "", message: NetworkError(.jsonParsingFailure).localizedDescription) {
                        completion(.failure(NetworkError(.jsonParsingFailure)))
                    }
                }
            }
        }
    }
    
    private func serializeResponse<T: Codable>(from data: Data, with decodingType: T.Type, and completion: @escaping JSONTaskCompletionHandler, request: URLRequest) {
        do {
            guard let _ = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                let error = NetworkError(.invalidData, statusCode: -1, data: nil)
                completion(nil, error)
                return
            }
            
            let baseResponse = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            let baseResponseData = baseResponse.data
            completion(baseResponseData, nil)
        } catch let DecodingError.typeMismatch(_, context)  {
            let errorFieldPath = "path: \(context.codingPath.map({ $0.stringValue }).reduce("", { $0 + " -> " + $1 }))"
            print(errorFieldPath)
            print(request.description)
            completion(nil, NetworkError(.jsonConversionFailure(error: "Данные не удалось прочитать так как они имеют неверный формат"), statusCode: -1))
        }
        catch {
            completion(nil, NetworkError(.jsonConversionFailure(error: error.localizedDescription), statusCode: -1))
        }
    }
    
}
