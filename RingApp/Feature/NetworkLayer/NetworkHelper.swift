//
//  NetworkHelper.swift
//  RingApp
//
//  Created by Emre on 12.04.2024.
//

import Foundation
import Alamofire

final class NetworkHelper {
    static let BASE_URL = ""
}

enum HTTPMethods {
    case get
    case post
}

extension HTTPMethods {
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
}

enum ErrorTypes: String,Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
}

