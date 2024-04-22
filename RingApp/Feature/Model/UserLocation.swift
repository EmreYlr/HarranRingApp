//
//  UserLocation.swift
//  RingApp
//
//  Created by Emre on 22.04.2024.
//

import Foundation

/// User Model
struct UserLocation: Codable {
    let latitude, longitude: Double
    let deviceId: String
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, deviceId
    }
}
