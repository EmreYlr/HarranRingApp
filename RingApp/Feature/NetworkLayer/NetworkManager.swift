//
//  NetworkManager.swift
//  RingApp
//
//  Created by Emre on 12.04.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    /// Request GET method
    
    func request<T: Codable>(from url: URL, method: HTTPMethods, parameters: Parameters? = nil, completion: @escaping (Result<T, ErrorTypes>) -> Void) {
        AF.request(url, method: method.toAlamofire(), parameters: parameters,encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                    completion(.failure(.invalidData))
                }
            }
    }
    /// Request POST method
    func requestDecodable(from url: URL, method: HTTPMethods, parameters: Parameters? = nil, completion: @escaping (Result<Void, ErrorTypes>) -> Void) {
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request(url, method: method.toAlamofire(), parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .response { response in
                switch response.response?.statusCode{
                case 200:
                    completion(.success(()))
                case 400:
                    print("Error")
                    completion(.failure(.invalidData))
                case .none:
                    completion(.failure(.invalidURL))
                case .some(_):
                    completion(.failure(.invalidURL))
                }
            }
    }
    
}
