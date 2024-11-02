//
//  ApiService.swift
//  TestPepe
//
//  Created by José De Jesús Vega López on 01/11/24.
//

import Foundation
import Combine

class ApiService: NSObject {
    
    static let shared = ApiService()
    private let configuration: URLSessionConfiguration
    private let bearerToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YzdhYWVlN2UwY2MzODljMzEwMDk5ZmUyMzUxMzU1YSIsIm5iZiI6MTczMDQ4NzIxNi40ODU5MTE2LCJzdWIiOiI2NzI0MzM0Njc5OGY3MjZkMTIyOGRjMDEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.6PFK3CKRZOCFn-rM-ajGUU6mHK00Uv5H1jyvuUwpz_k"
    private lazy var session = URLSession(configuration: self.configuration)
    
    override init() {
        self.configuration = URLSessionConfiguration.default
        self.configuration.timeoutIntervalForRequest = 60
        self.configuration.timeoutIntervalForResource = 60
    }
    
    func request<T: Decodable>(_ requestModel: ApiRequestModel, _ modelType: T.Type) async throws -> T {
        guard
            let serviceUrl = URLComponents(string: BaseUrl.getUrl(with: requestModel.endpoint)),
            let url = serviceUrl.url
        else {
            throw NetworkingError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = requestModel.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch requestModel.header {
        case .Authorization:
            request.setValue(self.bearerToken, forHTTPHeaderField: "Authorization")
            
        case .noHeader: break // do nothing
        }
        if let parameters = requestModel.parameters {
            if let encoding = requestModel.encoding {
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                switch encoding {
                case .url:
                    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    let percentEncodedQuery = (urlComponents?.percentEncodedQuery.map { $0 + "&" } ?? "") + self.query(parameters)
                    urlComponents?.percentEncodedQuery = percentEncodedQuery
                    request.url = urlComponents?.url

                case .json:
                    
                    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            }
        }
        let parameters = String(data: request.httpBody ?? Data(), encoding: .utf8)
        print("-------- REQUEST --------")
        print("METHOD: \(requestModel.method.rawValue)")
        print("URL: \(request.url?.absoluteString ?? "")")
        print("BODY: \( parameters ?? "")")
        
        do {
            let (data, response) = try await self.session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkingError.httpResponseError
            }
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                let decodeData = try decoder.decode(T.self, from: data)
                print("-------- REPSONSE --------")
                print("\( String(data: data, encoding: .utf8) ?? "")")
                return decodeData
            }
            else if httpResponse.statusCode == 500 {
                throw NetworkingError.serverError
            }
            else {
                throw NetworkingError.generalError
            }
        }
        catch {
            if (error as? URLError)?.code == .timedOut {
                throw NetworkingError.timeOut
            }
            else if (error as? URLError)?.code == .networkConnectionLost {
                throw NetworkingError.connectionLost
            }
            throw NetworkingError.generalError
        }
    }
    
    func query(_ parameters: ParameterType) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape("\(value.boolValue)")))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape("\(bool)")))
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }

    func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet: CharacterSet = .urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}

// MARK: - Convenience checks
fileprivate extension NSNumber {
    var isBool: Bool { CFBooleanGetTypeID() == CFGetTypeID(self) }
}

