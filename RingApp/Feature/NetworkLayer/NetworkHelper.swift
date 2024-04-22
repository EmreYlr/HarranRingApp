//
//  NetworkHelper.swift
//  RingApp
//
//  Created by Emre on 12.04.2024.
//

import Foundation
import Alamofire

final class NetworkHelper {
    static let BASE_URL = "http://rasperry.0guzhan.keenetic.link/api/v1/bus"
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

enum BusPath: String {
    case GETLASTLOCATION = "/getLastLocationByRange"
    case POSTLOCATION = "/location"
}

extension BusPath {
    func fullPath() -> String {
        return NetworkHelper.BASE_URL + self.rawValue
    }
}


enum ErrorTypes: String,Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
}

