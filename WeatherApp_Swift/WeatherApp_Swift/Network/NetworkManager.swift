//
//  NetworkManager.swift
//  WeatherApp_Swift
//
//  Created by Бауржан Еркен on 04.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let BaseURL = "https://api.weatherapi.com"
    
    private init() {}
    
    func fetchData(From urlString:String, parameters: [String:Any]?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: "\(BaseURL)/v1/\(urlString)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)")}
            guard let url = urlComponents.url else {
                completion(.failure(.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.get.rawValue
            
            print(url.absoluteString)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(.serverError("Server error: \(error.localizedDescription)")))
                    return
                }
                guard let httpResponce = response as? HTTPURLResponse, (200..<300).contains(httpResponce.statusCode) else {
                    completion(.failure(.serverError("Server error")))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                completion(.success(data))
            }
            task.resume()
        }
    }
}
