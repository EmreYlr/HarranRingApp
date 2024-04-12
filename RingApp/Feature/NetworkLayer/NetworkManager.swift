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
    
    func request<T: Codable>(from url: URL , method: HTTPMethods, parameters: [String: Any]? = nil, completion: @escaping(Swift.Result<T, ErrorTypes>) -> Void) {
        AF.request(url, method: method.toAlamofire(), parameters: parameters).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
}
